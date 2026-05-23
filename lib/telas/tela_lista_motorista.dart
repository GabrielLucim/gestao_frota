import 'package:flutter/material.dart';
import 'package:gestao_frota/dao/motorista_dao.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:gestao_frota/telas/tela_cadastro_motorista.dart';

class TelaListaMotorista extends StatefulWidget {
  @override
  _TelaListaMotoristaState createState() => _TelaListaMotoristaState();
}

class _TelaListaMotoristaState extends State<TelaListaMotorista> {
  final MotoristaDAO motoristaDAO = MotoristaDAO();

  late Future<List<Motorista>> motoristasFuture;

  @override
  void initState() {
    super.initState();

    motoristasFuture = motoristaDAO.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motoristas')),

      body: FutureBuilder<List<Motorista>>(
        future: motoristasFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum motorista cadastrado',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final motoristas = snapshot.data!;

          return ListView(
            padding: EdgeInsets.all(16),

            children: motoristas.map((Motorista m) {
              return Card(
                child: ListTile(
                  title: Text(m.nome),

                  subtitle: Text(
                    'CNH: ${m.categoria_cnh}\n'
                    'CPF: ${m.cpf}\n'
                    'Idade: ${m.idade}\n'
                    'Nascimento: '
                    '${m.dataNascimento.day}/'
                    '${m.dataNascimento.month}/'
                    '${m.dataNascimento.year}',
                  ),

                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),

                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  TelaCadastroMotorista(motorista: m),
                            ),
                          );

                          setState(() {
                            motoristasFuture = motoristaDAO.listar();
                          });
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),

                        onPressed: () async {
                          await motoristaDAO.excluir(m.id!);

                          setState(() {
                            motoristasFuture = motoristaDAO.listar();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
