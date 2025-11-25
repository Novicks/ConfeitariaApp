class Usuario {
  int? _codigo;
  String? _nome;
  String? _email;
  String? _senha;
  String? _telefone;
  int? _cpf;

  Usuario({
    int? codigo,
    String? nome,
    String? email,
    String? senha,
    String? telefone,
    int? cpf,
  }) {
    _codigo = codigo;
    _nome = nome;
    _email = email;
    _senha = senha;
    _telefone = telefone;
    _cpf = cpf;
  }
  int? get codigo => _codigo;
  String? get nome => _nome;
  String? get email => _email;
  String? get senha => _senha;
  String? get telefone => _telefone;
  int? get cpf => _cpf;

  set cpf(int? cpf) => _cpf = cpf;
  set senha(String? senha) => _senha = senha;
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
