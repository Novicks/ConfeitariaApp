class Cliente {
  int? _codigo;
  String? _nome;
  String? _email;
  String? _telefone;
  String? _cpf;

  Cliente({
    int? codigo,
    String? nome,
    String? email,
    String? telefone,
    String? cpf,
  }) {
    _codigo = codigo;
    _nome = nome;
    _email = email;
    _telefone = telefone;
    _cpf = cpf;
  }
  int? get codigo => _codigo;
  String? get nome => _nome;
  String? get email => _email;
  String? get telefone => _telefone;
  String? get cpf => _cpf;

  set cpf(String? cpf) => _cpf = cpf;
  set telefone(String? telefone) => _telefone = telefone;
  set codigo(int? codigo) => _codigo = codigo;
  set nome(String? nome) => _nome = nome;
  set email(String? email) {
    if (email != null && email.contains('@')) {
      _email = email;
    } else {
      print('Email inválido');
    }
  }
}
