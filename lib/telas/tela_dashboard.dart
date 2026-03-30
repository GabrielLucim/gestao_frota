import 'package:flutter/material.dart';

class TelaDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/cadastro-veiculo'),
            child: Text('Cadastrar Veículo'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/lista-veiculos'),
            child: Text('Listar Veículos'),
          ),
          ElevatedButton(
            onPressed: () =>
                Navigator.pushNamed(context, '/cadastro-motorista'),
            child: Text('Cadastrar Motorista'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pushNamed(context, '/cadastro-entrega'),
            child: Text('Cadastrar Entrega'),
          ),
        ],
      ),
    );
  }
}
