import 'package:gestao_frota/banco/banco_helper.dart';
import 'package:gestao_frota/modelos/entrega.dart';
import 'package:sqflite/sqflite.dart';

class EntregaDAO {
  final BancoHelper _bancoHelper = BancoHelper();

  Future<int> inserir(Entrega entrega) async {
    Database db = await _bancoHelper.database;

    return await db.insert('entregas', entrega.toMap());
  }

  Future<List<Entrega>> listar() async {
    Database db = await _bancoHelper.database;

    List<Map<String, dynamic>> resultado = await db.query('entregas');

    return resultado.map((map) => Entrega.fromMap(map)).toList();
  }

  Future<int> atualizar(Entrega entrega) async {
    Database db = await _bancoHelper.database;

    return await db.update(
      'entregas',
      entrega.toMap(),

      where: 'id = ?',

      whereArgs: [entrega.id],
    );
  }

  Future<int> excluir(int id) async {
    Database db = await _bancoHelper.database;

    return await db.delete('entregas', where: 'id = ?', whereArgs: [id]);
  }
}
