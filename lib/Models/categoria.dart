class Categoria {
  int? _id;
  String? _nome;
  String? _descricao;

  Categoria({int? id, String? nome, String? descricao}) {
    _id = id;
    _nome = nome;
    _descricao = descricao;
  }

  // Getters
  int? get id => _id;
  String? get nome => _nome;
  String? get descricao => _descricao;

  // Setters
  set id(int? id) => _id = id;
  set nome(String? nome) => _nome = nome;
  set descricao(String? descricao) => _descricao = descricao;
}
