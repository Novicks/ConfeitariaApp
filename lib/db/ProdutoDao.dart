import 'package:confeitaria_app/Models/produto.dart';
import 'package:confeitaria_app/db/clienteDAO.dart';
import 'package:confeitaria_app/db/databaseHelper.dart';


class ProdutoDAO {

  static Future<void> atualizarProduto(
      int? cd,
      String? nome,
      int? tipo

      ) async{
    final db = await DatabaseHelper.getDatabase();

    final resultado = await db.update('tb_produto',
        {
          'nm_produto': nome,
          'cd_tipo': tipo
        },
        where: 'cd_produto = ?',
        whereArgs: [cd]

    );
  }

  static Future<Produto> listar(int? id) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_produto',
        where: 'cd_produto = ?',
        whereArgs: [id]
    );

    return Produto(
      codigo_do_produto: resultado.first['cd_produto'] as int,
      nome: resultado.first['nm_produto'] as String,
      codigo_categoria: await TipoDAO.listar(resultado.first['cd_tipo'] as int),

    );

  }

  static Future<void> excluir(Produto p) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.delete('tb_produto',
        where: 'cd_produto = ?',
        whereArgs: [p.codigo_do_produto]
    );
  }

  static Future<List<Produto>> listarTodos() async {
    final db =  await DatabaseHelper.getDatabase();
    final resultado = await db.query('tb_produto',
        where: 'cd_cliente = ?',
        whereArgs: [ClienteDAO.clienteLogado.codigo]
    );
    return resultado.map((mapa){
      return Produto(
          codigo_do_produto: mapa['cd_produto'] as int,
          nome: mapa['nm_produto'] as String
      );
    }).toList();
  }

  static Future<int> cadastrarProduto (
      String? nome,
      int? tipo
      ) async{
    final db = await DatabaseHelper.getDatabase();
    final dadosProduto = {
      'cd_tipo': tipo,
      'nm_produto': nome,
      'cd_cliente': ClienteDAO.clienteLogado.codigo
    };
    try{
      final idProduto = await db.insert('tb_produto', dadosProduto);
      return idProduto;
    } catch(e){
      print("Erro ao cadastrar produto: $e");
      return -1;
    }
  }

}