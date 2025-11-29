import 'package:flutter/material.dart';

class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nomeUsuarioController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
  TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _nomeUsuarioController.dispose();
    _senhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _cadastrar() {
    if (_formKey.currentState!.validate()) {
      // aqui depois você coloca para salvar no banco
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cadastro realizado com sucesso!')),
      );
      Navigator.pop(context); // volta para a tela de login
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Fundo com degradê rosinha
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFFC0CB), // rosa claro
              Color(0xFFFFE5D8), // creme rosado
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.4), // efeito “vidro”
                borderRadius: BorderRadius.circular(32),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Crie sua conta.',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 24),

                    // ----- EMAIL -----
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'example@email.com',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.25),
                        suffixIcon: const Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o email';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ----- NOME DE USUÁRIO -----
                    const Text(
                      'Nome de usuário',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _nomeUsuarioController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Seu nome aqui',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.25),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe o nome de usuário';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ----- SENHA -----
                    const Text(
                      'Senha',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _senhaController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.25),
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Informe a senha';
                        }
                        if (value.length < 4) {
                          return 'Senha muito curta';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // ----- CONFIRMAR SENHA -----
                    const Text(
                      'Confirma senha',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _confirmarSenhaController,
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: '********',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.25),
                        suffixIcon: const Icon(
                          Icons.visibility_off_outlined,
                          color: Colors.white,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      validator: (value) {
                        if (value != _senhaController.text) {
                          return 'As senhas não conferem';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    // ----- BOTÃO CADASTRAR -----
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _cadastrar,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFF9A1A1),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 4,
                        ),
                        child: const Text(
                          'Cadastrar',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

