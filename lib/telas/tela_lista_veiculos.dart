import 'package:flutter/material.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';
import 'package:gestao_frota/modelos/veiculo.dart';
import 'package:gestao_frota/telas/tela_cadastro_veiculo.dart';

class TelaListaVeiculos extends StatefulWidget {
  @override
  _TelaListaVeiculosState createState() => _TelaListaVeiculosState();
}

class _TelaListaVeiculosState extends State<TelaListaVeiculos> {
  final VeiculoDAO veiculoDAO = VeiculoDAO();

  late Future<List<Veiculo>> veiculosFuture;

  @override
  void initState() {
    super.initState();

    veiculosFuture = veiculoDAO.listar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Veículos')),

      body: FutureBuilder<List<Veiculo>>(
        future: veiculosFuture,

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'Nenhum veículo cadastrado',
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          final veiculos = snapshot.data!;

          return ListView(
            padding: EdgeInsets.all(16),

            children: veiculos.map((Veiculo v) {
              return Card(
                child: ListTile(
                  title: Text(v.modelo),

                  subtitle: Text(
                    'Placa: ${v.placa}\n'
                    'Fabricante: ${v.fabricante}\n'
                    'Ano: ${v.ano}\n'
                    'KM: ${v.kmRodados}',
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
                              builder: (_) => TelaCadastroVeiculo(veiculo: v),
                            ),
                          );

                          setState(() {
                            veiculosFuture = veiculoDAO.listar();
                          });
                        },
                      ),

                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),

                        onPressed: () async {
                          await veiculoDAO.excluir(v.id!);

                          setState(() {
                            veiculosFuture = veiculoDAO.listar();
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
