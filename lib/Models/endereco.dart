Class Endereco{
int? codigo
int? codigo Cliente
String? Endereco
int? CEP
String? Rua
int? Numero
String? complemento
String? Bairro
String? Cidade
string? Estado

Endereco({
  this.id,
  required this.rua,
  required this.numero,
  required this.bairro,
  required this.cidade,
  required this.estado,
  required this.cep,
  this.complemento = "",
});


// Getters
int? get id => _id;
String get rua => _rua;
String get numero => _numero;
String get bairro => _bairro;
String get cidade => _cidade;
String get estado => _estado;
String get cep => _cep;
String get complemento => _complemento;

// Setters
set id(int? value) => _id = value;
set rua(String value) => _rua = value;
set numero(String value) => _numero = value;
set bairro(String value) => _bairro = value;
set cidade(String value) => _cidade = value;
set estado(String value) => _estado = value;
set cep(String value) => _cep = value;
set complemento(String value) => _complemento = value;


}
