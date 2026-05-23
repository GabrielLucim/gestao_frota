import 'package:gestao_frota/banco/banco_helper.dart';
import 'package:gestao_frota/modelos/veiculo.dart';
import 'package:sqflite/sqflite.dart';

class VeiculoDAO {
  final BancoHelper _bancoHelper = BancoHelper();

  Future<int> inserir(Veiculo veiculo) async {
    Database db = await _bancoHelper.database;

    return await db.insert('veiculos', veiculo.toMap());
  }

  Future<List<Veiculo>> listar() async {
    Database db = await _bancoHelper.database;

    final List<Map<String, dynamic>> resultado = await db.query('veiculos');

    return resultado.map((map) {
      return Veiculo.fromMap(map);
    }).toList();
  }

  Future<int> atualizar(Veiculo veiculo) async {
    Database db = await _bancoHelper.database;

    return await db.update(
      'veiculos',
      veiculo.toMap(),
      where: 'id = ?',
      whereArgs: [veiculo.id],
    );
  }

  Future<int> excluir(int id) async {
    Database db = await _bancoHelper.database;

    return await db.delete('veiculos', where: 'id = ?', whereArgs: [id]);
  }
}
