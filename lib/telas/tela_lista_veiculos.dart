import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';

class TelaListaVeiculos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Veículos')),
      body: ListView.builder(
        itemCount: Dados.veiculos.length,
        itemBuilder: (context, i) {
          final v = Dados.veiculos[i];
          return ListTile(
            title: Text(v.modelo),
            subtitle: Text('${v.placa} - ${v.fabricante}'),
          );
        },
      ),
    );
  }
}
