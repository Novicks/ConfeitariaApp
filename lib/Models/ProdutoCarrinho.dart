import 'package:confeitaria_app/Models/produto.dart';

class ProdutoCarrinho {
  final Produto p;
  int quantidade;

  ProdutoCarrinho({
    required this.p,
    this.quantidade = 1,
  });

  double get subtotal {
    final preco = p.preco ?? 0.0;
    return preco * quantidade;
  }
}