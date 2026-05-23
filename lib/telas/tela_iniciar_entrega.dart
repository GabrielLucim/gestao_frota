import 'package:flutter/material.dart';

import 'package:gestao_frota/dao/entrega_dao.dart';
import 'package:gestao_frota/dao/motorista_dao.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';

import 'package:gestao_frota/modelos/entrega.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaIniciarEntrega extends StatefulWidget {
  @override
  _TelaIniciarEntregaState createState() => _TelaIniciarEntregaState();
}

class _TelaIniciarEntregaState extends State<TelaIniciarEntrega> {
  final EntregaDAO entregaDAO = EntregaDAO();

  final VeiculoDAO veiculoDAO = VeiculoDAO();

  final MotoristaDAO motoristaDAO = MotoristaDAO();

  List<Entrega> entregas = [];

  List<Veiculo> veiculos = [];

  List<Motorista> motoristas = [];

  int? entregaSelecionadaId;

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  Future<void> carregarDados() async {
    entregas = await entregaDAO.listar();

    veiculos = await veiculoDAO.listar();

    motoristas = await motoristaDAO.listar();

    setState(() {});
  }

  Entrega? get entregaSelecionada {
    try {
      return entregas.firstWhere((e) => e.id == entregaSelecionadaId);
    } catch (e) {
      return null;
    }
  }

  Veiculo? buscarVeiculo(int id) {
    try {
      return veiculos.firstWhere((v) => v.id == id);
    } catch (e) {
      return null;
    }
  }

  Motorista? buscarMotorista(int id) {
    try {
      return motoristas.firstWhere((m) => m.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> iniciarEntrega() async {
    if (entregaSelecionada == null) {
      return;
    }

    entregaSelecionada!.status = StatusEntrega.emAndamento;

    entregaSelecionada!.dataInicio = DateTime.now();

    await entregaDAO.atualizar(entregaSelecionada!);

    await carregarDados();

    setState(() {});
  }

  Future<void> finalizarEntrega() async {
    if (entregaSelecionada == null) {
      return;
    }

    entregaSelecionada!.status = StatusEntrega.concluida;

    entregaSelecionada!.dataFim = DateTime.now();

    await entregaDAO.atualizar(entregaSelecionada!);

    setState(() {
      entregaSelecionadaId = null;
    });

    await carregarDados();
  }

  Future<void> cancelarEntrega() async {
    if (entregaSelecionada == null) {
      return;
    }

    entregaSelecionada!.status = StatusEntrega.cancelada;

    entregaSelecionada!.dataFim = DateTime.now();

    await entregaDAO.atualizar(entregaSelecionada!);

    setState(() {
      entregaSelecionadaId = null;
    });

    await carregarDados();
  }

  String formatarData(DateTime? data) {
    if (data == null) {
      return '-';
    }

    return '${data.day}/${data.month}/${data.year}';
  }

  String textoStatus(StatusEntrega status) {
    switch (status) {
      case StatusEntrega.pendente:
        return 'Pendente';

      case StatusEntrega.emAndamento:
        return 'Em andamento';

      case StatusEntrega.concluida:
        return 'Concluída';

      case StatusEntrega.cancelada:
        return 'Cancelada';
    }
  }

  @override
  Widget build(BuildContext context) {
    final entrega = entregaSelecionada;

    Veiculo? veiculo;

    Motorista? motorista;

    if (entrega != null) {
      veiculo = buscarVeiculo(entrega.veiculoId);

      motorista = buscarMotorista(entrega.motoristaId);
    }

    return Scaffold(
      appBar: AppBar(title: Text('Iniciar Entrega')),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            DropdownButtonFormField<int>(
              value: entregaSelecionadaId,

              decoration: InputDecoration(
                labelText: 'Selecione uma entrega',
                border: OutlineInputBorder(),
              ),

              items: entregas
                  .where(
                    (e) =>
                        e.status == StatusEntrega.pendente ||
                        e.status == StatusEntrega.emAndamento,
                  )
                  .map((e) {
                    final v = buscarVeiculo(e.veiculoId);

                    final m = buscarMotorista(e.motoristaId);

                    return DropdownMenuItem<int>(
                      value: e.id,

                      child: Text(
                        '${e.destino} - '
                        '${v?.modelo ?? '-'} '
                        '(${m?.nome ?? '-'}) '
                        '[${textoStatus(e.status)}]',
                      ),
                    );
                  })
                  .toList(),

              onChanged: (id) {
                setState(() {
                  entregaSelecionadaId = id;
                });
              },
            ),

            SizedBox(height: 20),

            if (entrega != null)
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,

                    children: [
                      Text('Destino: ${entrega.destino}'),

                      SizedBox(height: 8),

                      Text('Veículo: ${veiculo?.modelo ?? '-'}'),

                      SizedBox(height: 8),

                      Text('Motorista: ${motorista?.nome ?? '-'}'),

                      SizedBox(height: 8),

                      Text('Status: ${textoStatus(entrega.status)}'),

                      SizedBox(height: 8),

                      Text('Início: ${formatarData(entrega.dataInicio)}'),

                      SizedBox(height: 8),

                      Text('Fim: ${formatarData(entrega.dataFim)}'),
                    ],
                  ),
                ),
              ),

            SizedBox(height: 20),

            ElevatedButton(
              onPressed:
                  entrega != null && entrega.status == StatusEntrega.pendente
                  ? iniciarEntrega
                  : null,

              child: Text('Iniciar Entrega'),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed:
                  entrega != null && entrega.status == StatusEntrega.emAndamento
                  ? finalizarEntrega
                  : null,

              child: Text('Finalizar Entrega'),
            ),

            SizedBox(height: 10),

            ElevatedButton(
              onPressed:
                  entrega != null && entrega.status == StatusEntrega.emAndamento
                  ? cancelarEntrega
                  : null,

              child: Text('Cancelar Entrega'),
            ),
          ],
        ),
      ),
    );
  }
}
