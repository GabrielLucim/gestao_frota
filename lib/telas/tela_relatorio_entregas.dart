import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/entrega.dart';

class TelaRelatorioEntregas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int total = Dados.entregas.length;

    int pendentes = Dados.entregas
        .where((e) => e.status == StatusEntrega.pendente)
        .length;

    int emAndamento = Dados.entregas
        .where((e) => e.status == StatusEntrega.emAndamento)
        .length;

    int concluidas = Dados.entregas
        .where((e) => e.status == StatusEntrega.concluida)
        .length;

    int canceladas = Dados.entregas
        .where((e) => e.status == StatusEntrega.cancelada)
        .length;

    return Scaffold(
      appBar: AppBar(title: Text('Relatório de Entregas')),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              child: ListTile(
                title: Text('Total de Entregas'),
                trailing: Text('$total'),
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Pendentes'),
                trailing: Text('$pendentes'),
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Em andamento'),
                trailing: Text('$emAndamento'),
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Concluídas'),
                trailing: Text('$concluidas'),
              ),
            ),

            Card(
              child: ListTile(
                title: Text('Canceladas'),
                trailing: Text('$canceladas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
