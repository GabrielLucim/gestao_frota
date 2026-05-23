import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BancoHelper {
  static final BancoHelper _instancia = BancoHelper._interno();

  factory BancoHelper() => _instancia;

  BancoHelper._interno();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _iniciarBanco();
    return _database!;
  }

  Future<Database> _iniciarBanco() async {
    final caminhoBanco = await getDatabasesPath();

    final caminho = join(caminhoBanco, 'gestao_frota.db');

    return await openDatabase(caminho, version: 2, onCreate: _criarTabelas);
  }

  Future<void> _criarTabelas(Database db, int version) async {
    await db.execute('''
      CREATE TABLE veiculos(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        modelo TEXT,
        placa TEXT,
        fabricante TEXT,
        ano INTEGER,
        kmRodados REAL
      )
    ''');

    await db.execute('''
      CREATE TABLE motoristas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT,
        categoria_cnh TEXT,
        cpf TEXT,
        dataNascimento TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE entregas(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        destino TEXT,
        veiculoId INTEGER,
        motoristaId INTEGER,
        status TEXT,
        dataInicio TEXT,
        dataFim TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE manutencoes(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        custo REAL,
        veiculoId INTEGER,
        status TEXT,
        dataInicio TEXT,
        dataFim TEXT
      )
    ''');
  }
}
