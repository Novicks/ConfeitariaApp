import 'package:confeitaria_app/db/databaseHelper.dart';
import 'package:confeitaria_app/models/cliente.dart';

class ClienteDAO {
  static Cliente clienteLogado = Cliente();

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
}
