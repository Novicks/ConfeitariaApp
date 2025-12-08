import 'package:confeitaria_app/db/databaseHelper.dart';
import 'package:confeitaria_app/models/cliente.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
class ClienteDAO {
  static Cliente clienteLogado = Cliente();

  String gerarSenhaHash(String senha){
    final bytes = utf8.encode(senha);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  static Future<Cliente?> autenticar(String email, String senha) async {
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query(
      'cliente',
      where: 'email = ? and senha_hash = ?',
      whereArgs: [email, senha],
    );

    if(resultado.isEmpty){
      return null;
    }

    final map = resultado.first;
    // adicionar usuario logado depois
    clienteLogado.codigo = map['id_cliente'] as int;
    clienteLogado.nome = map['nome'] as String;
    clienteLogado.email = map['email'] as String;
    clienteLogado.cpf = map['cpf'] as String;
    clienteLogado.telefone = map['telefone'] as String;
    return clienteLogado;
  }
  static Future<int> cadastrarCliente(String? nome, String? email, String? senha_hash, String? senha_hashC, String? telefone, String? cpf) async{
    final db = await DatabaseHelper.getDatabase();
    if(senha_hash == senha_hashC){
      final dadosDeCadastro = {
        'nome': nome,
        'email': email,
        'senha_hash': senha_hash,
        'telefone': telefone,
        'cpf':cpf,
        'data_cadastro': DateTime.now().toString(),
        'ativo': 1
      };
      try{
        final idCliente = await db.insert('cliente', dadosDeCadastro);
        return idCliente;
      }catch(e){
        print("Erro ao cadastrar Cliente: $e");
        return -1;
      }
    }
  }

}
