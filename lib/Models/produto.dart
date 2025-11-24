
Class Produto;
int? Codigo do produto;
int? Codigo Categoria;
String? Nome;
String? Descricao;
int? Preco;

//Construtor

Produto({
int? codigo produto;
int? codigo categoria;
String? nome, String descricao;
int? preco;

int? get codigo produto => codigo produto;
int? get codigo categoria => codigo categoria
int? preco
String? nome, String? descricao({
_codigo do produto = codigo do produto;
_codigo da categoria = codigo da categoria;
_nome = nome;
_descricao = descricao;
_preco = preco;

})
//Getter e Setters
//exemplo tradicional de getter
String get categoria{
return _descricao;

int? get codigo do produto => codigo do produto;
int? get codigo categoria => codigo categoria;
int? preco = preco;
String? get nome => nome;
String? get descricao => descricao;
}


//setters tradicional
set categoria(String? descricao){
_descricao = descricao;

}
//setters estilo dart
set codigo(int? codigo do produto) =>  _codigo do produto = codigo do produto;
set codigo(int? codigo categoria) =>  _codigo categoria = codigo categoria;
set preco(int? preco) => _preco = preco;
set nome(String? nome) => _nome = nome;
set descricao(String? descricao)=> _descricao = descricao;


