import 'package:flutter/material.dart';

import 'package:gestao_frota/dao/entrega_dao.dart';
import 'package:gestao_frota/modelos/entrega.dart';

class TelaRelatorioEntregas extends StatefulWidget {
  @override
  _TelaRelatorioEntregasState createState() => _TelaRelatorioEntregasState();
}

class _TelaRelatorioEntregasState extends State<TelaRelatorioEntregas> {
  final EntregaDAO entregaDAO = EntregaDAO();

  List<Entrega> entregas = [];

  @override
  void initState() {
    super.initState();

    carregarEntregas();
  }

  Future<void> carregarEntregas() async {
    final lista = await entregaDAO.listar();

    setState(() {
      entregas = lista;
    });
  }

  @override
  Widget build(BuildContext context) {
    int total = entregas.length;

    int pendentes = entregas
        .where((e) => e.status == StatusEntrega.pendente)
        .length;

    int emAndamento = entregas
        .where((e) => e.status == StatusEntrega.emAndamento)
        .length;

    int concluidas = entregas
        .where((e) => e.status == StatusEntrega.concluida)
        .length;

    int canceladas = entregas
        .where((e) => e.status == StatusEntrega.cancelada)
        .length;

    return Scaffold(
      appBar: AppBar(title: Text('Relatório de Entregas')),

      body: Center(
        child: Container(
          width: 350,

          padding: EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white,

            borderRadius: BorderRadius.circular(20),

            boxShadow: [
              BoxShadow(
                blurRadius: 12,

                color: Colors.black26,

                offset: Offset(0, 4),
              ),
            ],
          ),

          child: Column(
            mainAxisSize: MainAxisSize.min,

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
      ),
    );
  }
}
