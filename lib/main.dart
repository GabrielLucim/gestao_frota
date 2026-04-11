import 'package:flutter/material.dart';
import 'telas/tela_busca_geral.dart';
import 'telas/tela_login.dart';
import 'telas/tela_relatorio_entregas.dart';
import 'telas/tela_dashboard.dart';
import 'telas/tela_cadastro_veiculo.dart';
import 'telas/tela_lista_veiculos.dart';
import 'telas/tela_cadastro_motorista.dart';
import 'telas/tela_cadastro_entrega.dart';
import 'telas/tela_lista_motorista.dart';
import 'telas/tela_iniciar_entrega.dart';

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
        '/': (context) => TelaLogin(),
        '/dashboard': (context) => TelaDashboard(),
        '/busca-geral': (context) => TelaBuscaGeral(),
        '/cadastro-veiculo': (context) => TelaCadastroVeiculo(),
        '/lista-veiculos': (context) => TelaListaVeiculos(),
        '/cadastro-motorista': (context) => TelaCadastroMotorista(),
        '/lista-motoristas': (context) => TelaListaMotorista(),
        '/cadastro-entrega': (context) => TelaCadastroEntrega(),
        '/iniciar-entrega': (context) => TelaIniciarEntrega(),
        '/relatorio-entregas': (context) => TelaRelatorioEntregas(),
      },
    );
  }
}
