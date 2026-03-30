import 'package:flutter/material.dart';
import 'package:gestao_frota/dados.dart';
import 'package:gestao_frota/modelos/entrega.dart';

class TelaCadastroEntrega extends StatefulWidget {
  @override
  _TelaCadastroEntregaState createState() => _TelaCadastroEntregaState();
}

class _TelaCadastroEntregaState extends State<TelaCadastroEntrega> {
  String destino = '';
  dynamic veiculo;
  dynamic motorista;

  void salvar() {
    Dados.entregas.add(
      Entrega(destino: destino, veiculo: veiculo, motorista: motorista),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entrega')),
      body: Column(
        children: [
          TextField(onChanged: (v) => destino = v),
          DropdownButton(
            hint: Text('Veículo'),
            items: Dados.veiculos.map((v) {
              return DropdownMenuItem(value: v, child: Text(v.modelo));
            }).toList(),
            onChanged: (v) => veiculo = v,
          ),
          DropdownButton(
            hint: Text('Motorista'),
            items: Dados.motoristas.map((m) {
              return DropdownMenuItem(value: m, child: Text(m.nome));
            }).toList(),
            onChanged: (m) => motorista = m,
          ),
          ElevatedButton(onPressed: salvar, child: Text('Salvar')),
        ],
      ),
    );
  }
}
