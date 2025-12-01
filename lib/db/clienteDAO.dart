import 'package:confeitaria_app/db/databaseHelper.dart';
import 'package:confeitaria_app/models/cliente.dart';

class ClienteDAO{
  static Cliente clienteLogado = Cliente();

  static Future<bool> autenticar(String email, String senha) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('cliente',
    where:'email = ? and senha_hash = ?',
    whereArgs: [email, senha]);

    // adicionar usuario logado depois
    clienteLogado.codigo = resultado.first['id_cliente'] as int;
    clienteLogado.nome = resultado.first['nome'] as String;
    clienteLogado.cpf = resultado.first['email'] as int;
    clienteLogado.telefone = resultado.first['n'] as String;
    clienteLogado.email = resultado.first['nome'] as String;
    return resultado.isNotEmpty;
  }
}