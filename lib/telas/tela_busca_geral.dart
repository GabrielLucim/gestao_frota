import 'package:flutter/material.dart';
import 'package:gestao_frota/dao/motorista_dao.dart';
import 'package:gestao_frota/dao/veiculo_dao.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaBuscaGeral extends StatefulWidget {
  @override
  _TelaBuscaGeralState createState() => _TelaBuscaGeralState();
}

class _TelaBuscaGeralState extends State<TelaBuscaGeral> {
  final MotoristaDAO motoristaDAO = MotoristaDAO();

  final VeiculoDAO veiculoDAO = VeiculoDAO();

  String busca = '';

  List<Motorista> motoristas = [];

  List<Veiculo> veiculos = [];

  @override
  void initState() {
    super.initState();

    carregarDados();
  }

  Future<void> carregarDados() async {
    final listaMotoristas = await motoristaDAO.listar();

    final listaVeiculos = await veiculoDAO.listar();

    setState(() {
      motoristas = listaMotoristas;
      veiculos = listaVeiculos;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Motorista> motoristasFiltrados = motoristas.where((m) {
      return m.nome.toLowerCase().contains(busca.toLowerCase());
    }).toList();

    List<Veiculo> veiculosFiltrados = veiculos.where((v) {
      return v.modelo.toLowerCase().contains(busca.toLowerCase()) ||
          v.placa.toLowerCase().contains(busca.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: Text('Busca Geral')),

      body: Padding(
        padding: EdgeInsets.all(16),

        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Buscar motorista ou veículo',
                border: OutlineInputBorder(),
              ),

              onChanged: (value) {
                setState(() {
                  busca = value;
                });
              },
            ),

            SizedBox(height: 20),

            Expanded(
              child: ListView(
                children: [
                  if (motoristasFiltrados.isNotEmpty)
                    Text(
                      'Motoristas',

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ...motoristasFiltrados.map(
                    (m) => Card(
                      child: ListTile(
                        title: Text(m.nome),

                        subtitle: Text('CPF: ${m.cpf}'),

                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            confirmarExclusaoMotorista(m);
                          },
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20),

                  if (veiculosFiltrados.isNotEmpty)
                    Text(
                      'Veículos',

                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                  ...veiculosFiltrados.map(
                    (v) => Card(
                      child: ListTile(
                        title: Text(v.modelo),

                        subtitle: Text('Placa: ${v.placa}'),

                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),

                          onPressed: () {
                            confirmarExclusaoVeiculo(v);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void confirmarExclusaoMotorista(Motorista m) {
    showDialog(
      context: context,

      builder: (_) => AlertDialog(
        title: Text('Confirmar'),

        content: Text('Excluir motorista?'),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),

            child: Text('Cancelar'),
          ),

          TextButton(
            onPressed: () async {
              await motoristaDAO.excluir(m.id!);

              Navigator.pop(context);

              carregarDados();
            },

            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }

  void confirmarExclusaoVeiculo(Veiculo v) {
    showDialog(
      context: context,

      builder: (_) => AlertDialog(
        title: Text('Confirmar'),

        content: Text('Excluir veículo?'),

        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),

            child: Text('Cancelar'),
          ),

          TextButton(
            onPressed: () async {
              await veiculoDAO.excluir(v.id!);

              Navigator.pop(context);

              carregarDados();
            },

            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}
