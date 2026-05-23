import 'package:flutter/material.dart';

import 'package:gestao_frota/dao/manutencao_dao.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';

import 'package:gestao_frota/modelos/manutencao.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaManutencao extends StatefulWidget {
  @override
  _TelaManutencaoState createState() => _TelaManutencaoState();
}

class _TelaManutencaoState extends State<TelaManutencao> {
  final formKey = GlobalKey<FormState>();

  final ManutencaoDAO manutencaoDAO = ManutencaoDAO();

  final VeiculoDAO veiculoDAO = VeiculoDAO();

  List<Manutencao> manutencoes = [];

  List<Veiculo> veiculos = [];

  Veiculo? veiculoSelecionado;

  String descricao = '';

  double custo = 0;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  Future<void> carregarDados() async {
    final listaManutencoes = await manutencaoDAO.listar();

    final listaVeiculos = await veiculoDAO.listar();

    setState(() {
      manutencoes = listaManutencoes;

      veiculos = listaVeiculos;
    });
  }

  Future<void> salvar() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    formKey.currentState!.save();

    Manutencao manutencao = Manutencao(
      descricao: descricao,
      custo: custo,
      veiculoId: veiculoSelecionado!.id!,
    );

    await manutencaoDAO.inserir(manutencao);

    formKey.currentState!.reset();

    carregarDados();
  }

  Veiculo? buscarVeiculo(int id) {
    try {
      return veiculos.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> iniciarManutencao(Manutencao manutencao) async {
    manutencao.status = StatusManutencao.emAndamento;

    manutencao.dataInicio = DateTime.now();

    await manutencaoDAO.atualizar(manutencao);

    carregarDados();
  }

  Future<void> finalizarManutencao(Manutencao manutencao) async {
    manutencao.status = StatusManutencao.concluida;

    manutencao.dataFim = DateTime.now();

    await manutencaoDAO.atualizar(manutencao);

    carregarDados();
  }

  String formatarData(DateTime? data) {
    if (data == null) {
      return '-';
    }

    return '${data.day}/${data.month}/${data.year}';
  }

  String textoStatus(StatusManutencao status) {
    switch (status) {
      case StatusManutencao.aberta:
        return 'Aberta';

      case StatusManutencao.emAndamento:
        return 'Em andamento';

      case StatusManutencao.concluida:
        return 'Concluída';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Manutenção')),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            Form(
              key: formKey,

              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      border: OutlineInputBorder(),
                    ),

                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Informe a descrição';
                      }

                      return null;
                    },

                    onSaved: (v) => descricao = v!,
                  ),

                  SizedBox(height: 15),

                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Custo',
                      border: OutlineInputBorder(),
                    ),

                    keyboardType: TextInputType.number,

                    validator: (v) {
                      if (v == null || v.isEmpty) {
                        return 'Informe o custo';
                      }

                      return null;
                    },

                    onSaved: (v) => custo = double.parse(v!),
                  ),

                  SizedBox(height: 15),

                  DropdownButtonFormField<Veiculo>(
                    decoration: InputDecoration(
                      labelText: 'Selecione um veículo',
                      border: OutlineInputBorder(),
                    ),

                    items: veiculos.map((v) {
                      return DropdownMenuItem(value: v, child: Text(v.modelo));
                    }).toList(),

                    onChanged: (v) {
                      veiculoSelecionado = v;
                    },

                    validator: (v) {
                      if (v == null) {
                        return 'Selecione um veículo';
                      }

                      return null;
                    },
                  ),

                  SizedBox(height: 20),

                  ElevatedButton(onPressed: salvar, child: Text('Salvar')),
                ],
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: manutencoes.map((m) {
                  final veiculo = buscarVeiculo(m.veiculoId);

                  return Card(
                    child: Padding(
                      padding: EdgeInsets.all(12),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Text(
                            m.descricao,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),

                          SizedBox(height: 8),

                          Text('Veículo: ${veiculo?.modelo ?? '-'}'),

                          Text('Custo: R\$ ${m.custo}'),

                          Text('Status: ${textoStatus(m.status)}'),

                          Text('Início: ${formatarData(m.dataInicio)}'),

                          Text('Fim: ${formatarData(m.dataFim)}'),

                          SizedBox(height: 10),

                          Row(
                            children: [
                              ElevatedButton(
                                onPressed: m.status == StatusManutencao.aberta
                                    ? () => iniciarManutencao(m)
                                    : null,

                                child: Text('Iniciar'),
                              ),

                              SizedBox(width: 10),

                              ElevatedButton(
                                onPressed:
                                    m.status == StatusManutencao.emAndamento
                                    ? () => finalizarManutencao(m)
                                    : null,

                                child: Text('Finalizar'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
