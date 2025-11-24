//categoria
int id;
String nome;
String descricao;
String imagemUrl; // opcional: foto da categoria (bolo, doces, tortas…)

class Categoria {
  int _id = 0;
  String _nome = "";
  String _descricao = "";
  String _imagemUrl = "";

  Categoria({
    required int id,
    required String nome,
    required String descricao,
    String imagemUrl = "",
  }) {
    _id = id;
    _nome = nome;
    _descricao = descricao;
    _imagemUrl = imagemUrl;
  }

  // Getters

  int get id => _id;
  String get nome => _nome;
  String get descricao => _descricao;
  String get imagemUrl => _imagemUrl;


  // Setters

  set id(int value) {
    if (value > 0) {
      _id = value;
    }
  }

  set nome(String value) {
    if (value.isNotEmpty) {
      _nome = value;
    }
  }

  set descricao(String value) {
    _descricao = value;
  }

  set imagemUrl(String value) {
    _imagemUrl = value;
  }