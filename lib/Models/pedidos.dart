class Pedido {
  int? _idPedido;
  int? _idCliente;
  String? _enderecoEntrega;
  DateTime? _dataPedido;
  double? _subTotal ;
  double? _taxaEntrega;
  double? _valorTotal;
  String? _observacoes;
  String? _status;
  String? _formaPagamento;

  // Construtor
  Pedido({
    int? idPedido,
    int? idCliente,
    String? enderecoEntrega,
    DateTime? dataPedido,
    double? subTotal,
    double? taxaEntrega,
    double? valorTotal,
    String? Observacoes,
    String? status,
    String? formaPagamento,
  }) {
    _idPedido = idPedido;
    _idCliente = idCliente;
    _enderecoEntrega = enderecoEntrega;
    _dataPedido = dataPedido;
    _subTotal = subTotal;
    _taxaEntrega = taxaEntrega;
    _valorTotal = valorTotal;
    observacoes = observacoes;
    _status = status;
    _formaPagamento = formaPagamento;
  }

  // Getters
  int? get idPedido => _idPedido;
  int? get idCliente => _idCliente;
  String? get enderecoEntrega => _enderecoEntrega;
  DateTime? get dataPedido => _dataPedido;
  double? get subTotal => _subTotal;
  double? get taxaEntrega => _taxaEntrega;
  double? get valorTotal => _valorTotal;
  String? get observacoes => _observacoes;
  String? get status => _status;
  String? get formaPagamento => _formaPagamento;

  // Setters
  set idPedido(int? idPedido) => _idPedido = idPedido;
  set idCliente(int? idCliente) => _idCliente = idCliente;
  set enderecoEntrega(String? enderecoEntrega) => _enderecoEntrega = enderecoEntrega;
  set dataPedido(DateTime? dataPedido) => _dataPedido = dataPedido;
  set subTotal(double? subTotal) => _subTotal = subTotal;
  set taxaEntrega(double? taxaEntrega) =>  _taxaEntrega = taxaEntrega;
  set valorTotal(double? valorTotal) => _valorTotal = valorTotal;
  set observacoes(String? observacoes) => observacoes = observacoes;
  set status(String? status) => _status = status;
  set formaPagamento(String? formaPagamento) => _formaPagamento = formaPagamento;
}
