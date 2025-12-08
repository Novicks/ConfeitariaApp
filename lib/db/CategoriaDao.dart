import 'package:confeitaria_app/Models/categoria.dart';
import 'package:confeitaria_app/db/databaseHelper.dart';

class CategoriaDAO{

  static Future<List<Categoria>> listarTipos() async{

    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_categoria');

    return resultado.map((mapa){
      return Categoria(
          codigo_do_produto: mapa['cd_categoria'] as int,
          descricao: mapa['nm_categoria'] as String
      );
    }).toList();
  }

  static Future<Categoria> listar(int? id) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_categoria',
        where: 'cd_categoria = ?',
        whereArgs: [id]
    );
    return Categoria(
        codigo_do_produto: resultado.first['cd_categoria'] as int,
        descricao: resultado.first['nm_categoria'] as String
    );
  }
}