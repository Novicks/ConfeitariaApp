import 'package:confeitaria_app/Models/categoria.dart';
import 'package:confeitaria_app/Models/produto.dart';
import 'package:confeitaria_app/db/CategoriaDao.dart';
import 'package:confeitaria_app/db/clienteDAO.dart';
import 'package:confeitaria_app/db/databaseHelper.dart';


class ProdutoDAO {

  static Future<List<Produto>> listarProdutoporCategoria(int? idCat) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('produtos',
        where: 'id_categoria = ?',
        whereArgs: [idCat]
    );

    return resultado.map((mapa){
      return Produto(
        codigo_do_produto: mapa['id_produto'] as int?,
        codigo_categoria: mapa['id_categoria'] as int?,
        nome: mapa['nome']?.toString() ?? '',
        descricao: mapa['descricao']?.toString() ?? '',
        preco: mapa['preco'] is num ? (mapa['preco'] as num).toDouble() : double.tryParse(mapa['preco'].toString()) ?? 0.0
      );
    }).toList();
  }
  // codigo para frente

}