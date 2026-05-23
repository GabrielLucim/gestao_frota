import 'package:flutter/material.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'telas/tela_busca_geral.dart';
import 'telas/tela_login.dart';
import 'telas/tela_relatorio_entregas.dart';
import 'telas/tela_dashboard.dart';

import 'telas/tela_cadastro_veiculo.dart';
import 'telas/tela_lista_veiculos.dart';

import 'telas/tela_cadastro_motorista.dart';
import 'telas/tela_lista_motorista.dart';

import 'telas/tela_cadastro_entrega.dart';
import 'telas/tela_iniciar_entrega.dart';

import 'telas/tela_manutencao.dart';

void main() {
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

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

        // VEÍCULOS
        '/cadastro-veiculo': (context) => TelaCadastroVeiculo(),

        '/lista-veiculos': (context) => TelaListaVeiculos(),

        // MOTORISTAS
        '/cadastro-motorista': (context) => TelaCadastroMotorista(),

        '/lista-motoristas': (context) => TelaListaMotorista(),

        // ENTREGAS
        '/cadastro-entrega': (context) => TelaCadastroEntrega(),

        '/iniciar-entrega': (context) => TelaIniciarEntrega(),

        '/relatorio-entregas': (context) => TelaRelatorioEntregas(),

        // MANUTENÇÃO
        '/manutencao': (context) => TelaManutencao(),
      },
    );
  }
}
