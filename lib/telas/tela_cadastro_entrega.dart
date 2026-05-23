import 'package:flutter/material.dart';

import 'package:gestao_frota/dao/entrega_dao.dart';
import 'package:gestao_frota/dao/motorista_dao.dart';
import 'package:gestao_frota/dao/manutencao_dao.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';

import 'package:gestao_frota/modelos/entrega.dart';
import 'package:gestao_frota/modelos/manutencao.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaCadastroEntrega extends StatefulWidget {
  @override
  _TelaCadastroEntregaState createState() => _TelaCadastroEntregaState();
}

class _TelaCadastroEntregaState extends State<TelaCadastroEntrega> {
  final formKey = GlobalKey<FormState>();

  final EntregaDAO entregaDAO = EntregaDAO();

  final VeiculoDAO veiculoDAO = VeiculoDAO();

  final MotoristaDAO motoristaDAO = MotoristaDAO();

  final ManutencaoDAO manutencaoDAO = ManutencaoDAO();

  String destino = '';

  Veiculo? veiculo;

  Motorista? motorista;

  List<Veiculo> veiculos = [];

  List<Motorista> motoristas = [];

  List<Manutencao> manutencoes = [];

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  Future<void> carregarDados() async {
    final listaVeiculos = await veiculoDAO.listar();

    final listaMotoristas = await motoristaDAO.listar();

    final listaManutencoes = await manutencaoDAO.listar();

    setState(() {
      veiculos = listaVeiculos;

      motoristas = listaMotoristas;

      manutencoes = listaManutencoes;
    });
  }

  bool veiculoEmManutencao(int veiculoId) {
    return manutencoes.any(
      (m) =>
          m.veiculoId == veiculoId && m.status == StatusManutencao.emAndamento,
    );
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (veiculo == null || motorista == null) {
      return;
    }

    if (veiculo!.id == null || motorista!.id == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: veículo ou motorista sem ID.')),
      );

      return;
    }

    if (veiculoEmManutencao(veiculo!.id!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Este veículo está em manutenção.')),
      );

      return;
    }

    formKey.currentState!.save();

    Entrega entrega = Entrega(
      destino: destino,
      veiculoId: veiculo!.id!,
      motoristaId: motorista!.id!,
    );

    await entregaDAO.inserir(entrega);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastro de Entrega')),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Form(
          key: formKey,

          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Destino',
                  border: OutlineInputBorder(),
                ),

                validator: (v) {
                  if (v == null || v.isEmpty) {
                    return 'Informe o destino';
                  }

                  return null;
                },

                onSaved: (v) => destino = v!,
              ),

              SizedBox(height: 15),

              DropdownButtonFormField<Veiculo>(
                decoration: InputDecoration(
                  labelText: 'Selecione um veículo',
                  border: OutlineInputBorder(),
                ),

                items: veiculos.map((v) {
                  bool emManutencao = veiculoEmManutencao(v.id!);

                  return DropdownMenuItem(
                    value: v,

                    enabled: !emManutencao,

                    child: Text(
                      emManutencao ? '${v.modelo} (EM MANUTENÇÃO)' : v.modelo,
                    ),
                  );
                }).toList(),

                onChanged: (v) {
                  veiculo = v;
                },

                validator: (v) => v == null ? 'Selecione um veículo' : null,
              ),

              SizedBox(height: 15),

              DropdownButtonFormField<Motorista>(
                decoration: InputDecoration(
                  labelText: 'Selecione um motorista',
                  border: OutlineInputBorder(),
                ),

                items: motoristas.map((m) {
                  return DropdownMenuItem(value: m, child: Text(m.nome));
                }).toList(),

                onChanged: (m) {
                  motorista = m;
                },

                validator: (m) => m == null ? 'Selecione um motorista' : null,
              ),

              SizedBox(height: 20),

              ElevatedButton(onPressed: salvar, child: Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
