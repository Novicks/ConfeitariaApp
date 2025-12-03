class Notificacao {
  int? _idNotificacao;
  int? _idCliente;
  String? _titulo;
  String? _mensagem;
  bool? _lida;
  DateTime? _dataEnvio;

  // Construtor
  Notificacao({
    int? idNotificacao,
    int? idCliente,
    String? titulo,
    String? mensagem,
    bool? lida,
    DateTime? dataEnvio,
  }) {
    _idNotificacao = idNotificacao;
    _idCliente = idCliente;
    _titulo = titulo;
    _mensagem = mensagem;
    _lida = lida;
    _dataEnvio = dataEnvio;
  }

  // Getters
  int? get idNotificacao => _idNotificacao;
  int? get idCliente => _idCliente;
  String? get titulo => _titulo;
  String? get mensagem => _mensagem;
  bool? get lida => _lida;
  DateTime? get dataEnvio => _dataEnvio;

  // Setters
  set idNotificacao(int? value) => _idNotificacao = value;
  set idCliente(int? value) => _idCliente = value;
  set titulo(String? value) => _titulo = value;
  set mensagem(String? value) => _mensagem = value;
  set lida(bool? value) => _lida = value;
  set dataEnvio(DateTime? value) => _dataEnvio = value;

}
