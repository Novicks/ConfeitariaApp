import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

/*class DBHelper {
  static final DBHelper instance = DBHelper._internal();
  static Database? _db;

  DBHelper._internal();

  Future<Database> get database async {
    if (_db != null) return _db!;
    Directory documentsDir = await getApplicationDocumentsDirectory();
    final path = join(documentsDir.path, 'confeitaria.db');
    _db = await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
    return _db!;
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE pedidos (
        id TEXT PRIMARY KEY,
        size TEXT,
        fillings TEXT,
        extras TEXT,
        message TEXT,
        notes TEXT,
        price REAL
      )
    ''');
  }

  Future<void> insertPedido(Map<String, dynamic> p) async {
    final db = await database;
    await db.insert('pedidos', p);
  }

  Future<List<Map<String,dynamic>>> getPedidos() async {
    final db = await database;
    return await db.query('pedidos');
  }
}

await DBHelper.instance.insertPedido({
'id': uuid,
'size': tamanhoSelecionado,
'fillings': jsonEncode(recheiosSelecionados),
'extras': jsonEncode(extrasSelecionados),
'message': mensagem,
'notes': observacoes,
'price': preco,
});*/