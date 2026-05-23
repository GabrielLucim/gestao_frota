import 'package:flutter/material.dart';

class TelaDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Menu'), centerTitle: true),
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
              Text(
                "Home",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/busca-geral'),
                child: Text('Busca Geral'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/cadastro-veiculo'),
                child: Text('Cadastrar Veículo'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/lista-veiculos'),
                child: Text('Listar Veículos'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/cadastro-motorista'),
                child: Text('Cadastrar Motorista'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/lista-motoristas'),
                child: Text('Listar Motoristas'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/cadastro-entrega'),
                child: Text('Cadastrar Entrega'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/iniciar-entrega'),
                child: Text('Iniciar Entrega'),
              ),
              SizedBox(height: 12),
              
              ElevatedButton(
                onPressed: () =>
                    Navigator.pushNamed(context, '/relatorio-entregas'),
                child: Text('Relatório de Entregas'),
              ),
              SizedBox(height: 12),

              ElevatedButton(
                onPressed: () => Navigator.pushNamed(context, '/manutencao'),

                child: Text('Manutenção'),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey.shade200,
    );
  }
}
