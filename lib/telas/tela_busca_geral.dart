import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:gestao_frota/modelos/veiculo.dart';

class TelaBuscaGeral extends StatefulWidget {
  @override
  _TelaBuscaGeralState createState() => _TelaBuscaGeralState();
}

class _TelaBuscaGeralState extends State<TelaBuscaGeral> {
  String busca = '';

  @override
  Widget build(BuildContext context) {
    List<Motorista> motoristas = Dados.motoristas
        .where((m) =>
            m.nome.toLowerCase().contains(busca.toLowerCase()))
        .toList();

    List<Veiculo> veiculos = Dados.veiculos
        .where((v) =>
            v.modelo.toLowerCase().contains(busca.toLowerCase()) ||
            v.placa.toLowerCase().contains(busca.toLowerCase()))
        .toList();

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
                  // MOTORISTAS
                  if (motoristas.isNotEmpty)
                    Text('Motoristas',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                  ...motoristas.map((m) => Card(
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
                      )),

                  SizedBox(height: 20),

                  // VEÍCULOS
                  if (veiculos.isNotEmpty)
                    Text('Veículos',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),

                  ...veiculos.map((v) => Card(
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
                      )),
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
            onPressed: () {
              setState(() {
                Dados.motoristas.remove(m);
              });
              Navigator.pop(context);
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
            onPressed: () {
              setState(() {
                Dados.veiculos.remove(v);
              });
              Navigator.pop(context);
            },
            child: Text('Excluir'),
          ),
        ],
      ),
    );
  }
}