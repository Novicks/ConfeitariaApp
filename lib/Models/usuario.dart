

Pasta models

Class Usuario{
int? _codigo;
String? _nome;
String? _email;
String? _senha;
String? _telefone;
int? _cpf;

//construtor
Usuario
int? codigo;
int? cpf;
String? nome, String? email, String? senha, String? telefone, int?cpf}){
_codigo = codigo;
_nome = nome;
_email = email;
_senha = senha;
_telefone = telefone;
_cpf = cpf;
}
//Getter e Setters
//exemplo tradicional de getter
String get email{
  return _senha;
}
int? get codigo => codigo;
String? get nome => nome;
String? get email => email;
String? get senha => senha;
String? get telefone => telefone;
int? cpf => cpf

}
//setters tradiicional
set email(String? senha){
  _senha = senha;

}
//setters estilo dart
set codigo(int? codigo) =>  _codigo = codigo;
set nome(String? nome)=> _nome = nome;
set email(String? email)=> _email = email;
set senha(String? senha)=> _senha = senha;
set telefone(String? telefone) => _telefone = telefone;
set cpf(int? cpf) => _cpf = cpf;




