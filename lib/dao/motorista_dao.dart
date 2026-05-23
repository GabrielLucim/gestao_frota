import 'package:gestao_frota/banco/banco_helper.dart';
import 'package:gestao_frota/modelos/motorista.dart';
import 'package:sqflite/sqflite.dart';

class MotoristaDAO {
  final BancoHelper _bancoHelper = BancoHelper();

  Future<int> inserir(Motorista motorista) async {
    Database db = await _bancoHelper.database;

    return await db.insert('motoristas', motorista.toMap());
  }

  Future<List<Motorista>> listar() async {
    Database db = await _bancoHelper.database;

    final List<Map<String, dynamic>> resultado = await db.query('motoristas');

    return resultado.map((map) {
      return Motorista.fromMap(map);
    }).toList();
  }

  Future<int> atualizar(Motorista motorista) async {
    Database db = await _bancoHelper.database;

    return await db.update(
      'motoristas',
      motorista.toMap(),
      where: 'id = ?',
      whereArgs: [motorista.id],
    );
  }

  Future<int> excluir(int id) async {
    Database db = await _bancoHelper.database;

    return await db.delete('motoristas', where: 'id = ?', whereArgs: [id]);
  }
}
