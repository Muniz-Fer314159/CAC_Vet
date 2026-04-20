import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('petshop.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE clientes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        telefone TEXT,
        email TEXT,
        endereco TEXT,
        cpf TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE animais (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        especie TEXT,
        raca TEXT,
        idade INTEGER,
        nome_dono TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        login TEXT NOT NULL,
        senha TEXT NOT NULL
      )
    ''');
  }
  
  Future<int> inserirCliente(Map<String, dynamic> cliente) async {
    final db = await instance.database;
    return await db.insert('clientes', cliente);
  }

  Future<int> inserirAnimal(Map<String, dynamic> animal) async {
    final db = await instance.database;
    return await db.insert('animais', animal);
  }

  Future<int> inserirUsuario(Map<String, dynamic> usuario) async {
    final db = await instance.database;
    return await db.insert('usuarios', usuario);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }

}