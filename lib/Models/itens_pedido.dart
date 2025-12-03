class ItensPedido {
  int? _idItemPedido;
  int? _idPedido;
  String? _idProduto;
  int? _quantidade;
  double? _precoUnitario;
  double? _subTotalItem;

  // Construtor
  ItensPedido({
    int? idItemPedido,
    int? idPedido,
    String? idProduto,
    int? quantidade,
    double? precoUnitario,
  }) {
    _idItemPedido = idItemPedido;
    _idPedido = idPedido;
    _idProduto = idProduto;
    _quantidade = quantidade;
    _precoUnitario = precoUnitario;

    _atualizarSubtotal();
  }

  // Getters
  int? get idItemPedido => _idItemPedido;
  int? get idPedido => _idPedido;
  String? get idProduto => _idProduto;
  int? get quantidade => _quantidade;
  double? get precoUnitario => _precoUnitario;
  double? get subTotalItem => _subTotalItem;

  // Setters
  set idItemPedido(int? valor) => _idItemPedido = valor;
  set idPedido(int? valor) => _idPedido = valor;

  set idProduto(String? valor) {
    _idProduto = valor;
  }

  set quantidade(int? valor) {
    _quantidade = valor;
    _atualizarSubtotal();
  }

  set precoUnitario(double? valor) {
    _precoUnitario = valor;
    _atualizarSubtotal();
  }

  // ======= MÉTODO PRIVADO PARA CALCULAR SUBTOTAL =======
  void _atualizarSubtotal() {
    if (_quantidade != null && _precoUnitario != null) {
      _subTotalItem = _quantidade! * _precoUnitario!;
    } else {
      _subTotalItem = 0;
    }
  }
}
