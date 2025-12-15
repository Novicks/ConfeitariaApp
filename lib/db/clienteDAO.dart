import 'dart:async';

import 'package:confeitaria_app/db/databaseHelper.dart';
import 'package:confeitaria_app/models/cliente.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ClienteDAO {
  static Cliente clienteLogado = Cliente();

  static Future<void> salvarClienteLogado(int clienteID) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('EstaLogado', true);
    await prefs.setInt('clienteID', clienteID);
  }

  static Future<bool> clientePresente() async{
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('EstaLogado') ?? false;
  }

  static Future<void> sair() async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static String gerarSenhaHash(String senha){
    final bytes = utf8.encode(senha);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
  static Future<Cliente?> autenticar(String email, String senha) async {
    final db = await DatabaseHelper.getDatabase();
    final  senhaHash = gerarSenhaHash(senha);
    final resultado = await db.query(
      'cliente',
      where: 'email = ? and senha_hash = ?',
      whereArgs: [email, senhaHash],
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
    int retorno = -1;
    if(senha_hash == senha_hashC){
      final dadosDeCadastro = {
        'nome': nome,
        'email': email,
        'senha_hash': gerarSenhaHash(senha_hash.toString()),
        'telefone': telefone,
        'cpf':cpf,
        'data_cadastro': DateTime.now().toString(),
        'ativo': 'ativo'
      };

      try{
        final idCliente = await db.insert('cliente', dadosDeCadastro);
        retorno= idCliente;
      }catch(e){
        print("Erro ao cadastrar Cliente: $e");
        retorno= -1;
      }
    }
    return retorno;
  }

}
