import 'dart:async';
import 'dart:core';
import 'package:confeitaria_app/Models/ProdutoCarrinho.dart';
import 'package:confeitaria_app/Models/itens_pedido.dart';
import 'package:confeitaria_app/Models/produto.dart';
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
  static Future<List<Produto>> listarProdutoporId(int? idP) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('produtos',
        where: 'id_produto = ?',
        whereArgs: [idP]
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

  static Future<int> itensPedidos(Produto? p, int? qtd) async{
    final db = await DatabaseHelper.getDatabase();
    int retorno = -1;
    final dadosPedido = {
      'id_produto': p?.codigo_do_produto,
      'quatidade': qtd,
      'preco_unitario': p?.preco
    };
    try{
      final itenPedido = await db.insert('itens_pedido', dadosPedido);
      retorno = itenPedido;
    } catch(e){
      print("erro ao cadastrar pedido: $e");
      retorno = -1;
    }
    return retorno;
  }
  static Future<List<ProdutoCarrinho>> listarCarrinho() async {
    final db = await DatabaseHelper.getDatabase();

    // Busca os itens do pedido do usuário logado
    final itens = await db.query(
      'itens_pedido',
      where: 'id_usuario = ?',
      whereArgs: [ClienteDAO.clienteLogado.codigo],
    );

    List<ProdutoCarrinho> carrinho = [];

    for (var item in itens) {
      final idProduto = item['id_produto'] as int;
      final quantidade = item['quantidade'] as int;

      // Busca o produto pelo ID
      final produtos = await listarProdutoporId(idProduto);

      if (produtos.isNotEmpty) {
        carrinho.add(
          ProdutoCarrinho(
            p: produtos.first,
            quantidade: quantidade,
          ),
        );
      }
    }

    return carrinho;
  }
}