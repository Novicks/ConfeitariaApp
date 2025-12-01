import 'package:confeitaria_app/db/clienteDAO.dart';
import 'package:confeitaria_app/pages/tela_inicial.dart';
import 'package:flutter/material.dart';
import 'tela_login.dart';

class TelaLogin extends StatelessWidget {
  TelaLogin({super.key});

  final TextEditingController ClienteController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Tela Login")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Cliente'),
              controller: ClienteController,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(labelText: 'Senha'),
              obscureText: true,
              controller: senhaController,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final sucesso = await ClienteDAO.autenticar(ClienteController.text, senhaController.text);
                if (sucesso) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => TelaInicial())
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Email ou senha inválidos!!"))
                  );
                }
              },
              child: const Text('logar'),
            ),
          ],
        ),
      ),
    );
  }
}
