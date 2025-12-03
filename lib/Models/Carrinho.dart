class Carrinho {
  int? _idCarrinho;
  int? _idCliente;
  int? _idItensPedido;
  String? _observacoes;
  DateTime? _dataAdicao;

  // Construtor
  Carrinho({
    int? idCarrinho,
    int? idCliente,
    int? idItensPedido,
    String? observacoes,
    DateTime? dataAdicao,
  }) {
    _idCarrinho = idCarrinho;
    _idCliente = idCliente;
    _idItensPedido = idItensPedido;
    _observacoes = observacoes;
    _dataAdicao = dataAdicao;
  }

  // Getters
  int? get idCarrinho => _idCarrinho;
  int? get idCliente => _idCliente;
  int? get idItensPedido => _idItensPedido;
  String? get observacoes => _observacoes;
  DateTime? get dataAdicao => _dataAdicao;

  // Setters
  set idCarrinho(int? value) => _idCarrinho = value;
  set idCliente(int? value) => _idCliente = value;
  set idItensPedido(int? value) => _idItensPedido = value;
  set observacoes(String? value) => _observacoes = value;
  set dataAdicao(DateTime? value) => _dataAdicao = value;
}






