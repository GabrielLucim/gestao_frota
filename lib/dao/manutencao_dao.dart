import 'package:gestao_frota/banco/banco_helper.dart';
import 'package:gestao_frota/modelos/manutencao.dart';
import 'package:sqflite/sqflite.dart';

class ManutencaoDAO {
  final BancoHelper _bancoHelper = BancoHelper();

  Future<int> inserir(Manutencao manutencao) async {
    Database db = await _bancoHelper.database;

    return await db.insert('manutencoes', manutencao.toMap());
  }

  Future<List<Manutencao>> listar() async {
    Database db = await _bancoHelper.database;

    List<Map<String, dynamic>> resultado = await db.query('manutencoes');

    return resultado.map((map) => Manutencao.fromMap(map)).toList();
  }

  Future<int> atualizar(Manutencao manutencao) async {
    Database db = await _bancoHelper.database;

    return await db.update(
      'manutencoes',
      manutencao.toMap(),

      where: 'id = ?',

      whereArgs: [manutencao.id],
    );
  }

  Future<int> excluir(int id) async {
    Database db = await _bancoHelper.database;

    return await db.delete('manutencoes', where: 'id = ?', whereArgs: [id]);
  }
}
