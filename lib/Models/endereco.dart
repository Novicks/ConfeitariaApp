class Endereco {
  int? _codigo_endereco;
  String? _endereco;
  int? _cep;
  String? _rua;
  int? _numero;
  String? _complemento;
  String? _bairro;
  String? _cidade;
  String? _estado;

  Endereco({
    int? codigo_endereco,
    String? endereco,
    int? cep,
    String? rua,
    int? numero,
    String? complemento,
    String? bairro,
    String? cidade,
    String? estado,
  }) {
    _codigo_endereco = codigo_endereco;
    _rua = rua;
    _numero = numero;
    _bairro = bairro;
    _cidade = cidade;
    _estado = estado;
    _cep = cep;
    _complemento = complemento;
    _endereco = endereco;
  }

  // Getters
  int? get codigo_endereco => _codigo_endereco;
  String? get endereco => _endereco;
  String? get rua => _rua;
  int? get numero => _numero;
  String? get complemento => _complemento;
  String? get bairro => _bairro;
  String? get cidade => _cidade;
  String? get estado => _estado;
  int? get cep => _cep;

  // Setters
  set codigo_endereco(int? codigoEndereco) => _codigo_endereco = codigoEndereco;
  set endereco(String? endereco) => _endereco = endereco;
  set rua(String? rua) => _rua = rua;
  set numero(int? numero) => _numero = numero;
  set complemento(String? complemento) => _complemento = complemento;
  set bairro(String? bairro) => _bairro = bairro;
  set cidade(String? cidade) => _cidade = cidade;
  set estado(String? estado) => _estado = estado;
  set cep(int? cep) => _cep = cep;
}
