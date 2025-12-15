class Produto {
  int? _codigo_do_produto;
  int? _codigo_categoria;
  String? _nome;
  String? _descricao;
  double? _preco;

  //construtor
  Produto({
    int? codigo_do_produto,
    int? codigo_categoria,
    String? nome,
    String? descricao,
    double? preco,
  }) {
    _codigo_do_produto = codigo_do_produto;
    _codigo_categoria = codigo_categoria;
    _nome = nome;
    _descricao = descricao;
    _preco = preco;
  }

  //getters tradicional
  int? get codigo_do_produto => _codigo_do_produto;
  int? get codigo_categoria => _codigo_categoria;
  double? get preco => _preco;
  String? get nome => _nome;
  String? get descricao => _descricao;

  //setters estilo dart
  set codigo_do_produto(int? codigoDoProduto) =>
      _codigo_do_produto = codigoDoProduto;
  set codigo_categoria(int? codigoCategoria) =>
      _codigo_categoria = codigoCategoria;
  set preco(double? preco) => _preco = preco;
  set nome(String? nome) => _nome = nome;
  set descricao(String? descricao) => _descricao = descricao;
}
