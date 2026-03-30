import 'package:flutter/material.dart';
import 'telas/tela_dashboard.dart';
import 'telas/tela_cadastro_veiculo.dart';
import 'telas/tela_lista_veiculos.dart';
import 'telas/tela_cadastro_motorista.dart';
import 'telas/tela_cadastro_entrega.dart';

void main() {
  runApp(AppFrota());
}

class AppFrota extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => TelaDashboard(),
        '/cadastro-veiculo': (context) => TelaCadastroVeiculo(),
        '/lista-veiculos': (context) => TelaListaVeiculos(),
        '/cadastro-motorista': (context) => TelaCadastroMotorista(),
        '/cadastro-entrega': (context) => TelaCadastroEntrega(),
      },
    );
  }
}
