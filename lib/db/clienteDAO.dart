import 'package:confeitaria_app/db/databaseHelper.dart';
import 'package:confeitaria_app/models/usuario.dart';

class ClienteDAO{
  static Cliente clienteLogado = Cliente();

  static Future<bool> autenticar(String email, String senha) async{
    final db = await DatabaseHelper.getDatabase();
    final resultado = await db.query('cliente',
    where:'email = ? and senha_hash = ?',
    whereArgs: [email, senha]);

    // adicionar usuario logado depois

    return resultado.isNotEmpty;
  }
}