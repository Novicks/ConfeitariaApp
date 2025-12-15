import 'package:confeitaria_app/Models/categoria.dart';
import 'package:confeitaria_app/db/databaseHelper.dart';

class CategoriaDAO{

  static Future<List<Categoria>> listarCategoria() async{

    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('categorias_produto');

    return resultado.map((mapa){
      return Categoria(
          id: mapa['id_categoria'] as int,
          nome : mapa['nome']?.toString() as String,
          descricao: mapa['descricao']?.toString() as String
      );
    }).toList();
  }
}