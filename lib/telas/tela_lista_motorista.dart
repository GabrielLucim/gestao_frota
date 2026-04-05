import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/motorista.dart';

class TelaListaMotorista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Motoristas')),

      body: Dados.motoristas.isEmpty
          ? Center(
              child: Text(
                'Nenhum motorista cadastrado',
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView(
              padding: EdgeInsets.all(16),
              children: Dados.motoristas.map((Motorista m) {
                return Card(
                  child: ListTile(
                    title: Text(m.nome),
                    subtitle: Text('CNH: ${m.categoria_cnh}\nCPF: ${m.cpf}\nIdade: ${m.idade}',
                    )
                  ),
                );
              }).toList(),
            ),
    );
  }
}
