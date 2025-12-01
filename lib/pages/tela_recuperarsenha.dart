import 'package:confeitaria_app/pages/tela_login.dart';
import 'package:flutter/material.dart';

class TelaRecuperarsenha extends StatefulWidget {
  const TelaRecuperarsenha({super.key});

  @override
  State<TelaRecuperarsenha> createState() => _TelaRecuperarsenha();
}

class _TelaRecuperarsenha extends State<TelaRecuperarsenha> {
  final _formKey = GlobalKey<FormState>();

  // Controladores
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codigoController = TextEditingController();
  final TextEditingController _novaSenhaController = TextEditingController();
  final TextEditingController _confirmarSenhaController =
      TextEditingController();

  int _etapa = 0;
  bool _senhaVisivel = false;

  @override
  void dispose() {
    _emailController.dispose();
    _codigoController.dispose();
    _novaSenhaController.dispose();
    _confirmarSenhaController.dispose();
    super.dispose();
  }

  void _pensador() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        if (_etapa == 0) {
          // --- ENVIAR EMAIL ---
          print("Enviando código para: ${_emailController.text}");
          _etapa = 1;
        } else if (_etapa == 1) {
          // --- VERIFICAR CÓDIGO ---
          print("Validando código: ${_codigoController.text}");
          _etapa = 2;
        } else if (_etapa == 2) {
          print("Senha alterada com sucesso!");

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Senha redefinida! Faça login novamente.'),
              backgroundColor: Colors.green,
            ),
          );

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TelaLogin()),
          );
        }
      });
    }
  }

  String _getTitulo() {
    switch (_etapa) {
      case 0:
        return 'Recuperar Senha';
      case 1:
        return 'Verificar Código';
      case 2:
        return 'Nova Senha';
      default:
        return '';
    }
  }

  String _getTextoBotao() {
    switch (_etapa) {
      case 0:
        return 'Enviar Código';
      case 1:
        return 'Verificar';
      case 2:
        return 'Redefinir Senha';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFFFC0CB), Color(0xFFFFE5D8)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4),
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
                      Text(
                        _getTitulo(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // (EMAIL)
                      if (_etapa == 0) ...[
                        _buildLabel('Insira o seu Email'),
                        _buildTextField(
                          controller: _emailController,
                          hint: 'seuemail@gmail.com',
                          icon: Icons.email_outlined,
                        ),
                      ],

                      // ETAPA (CÓDIGO)
                      if (_etapa == 1) ...[
                        Text(
                          'Enviamos um código para ${_emailController.text}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 16),
                        _buildLabel('Código de Verificação'),
                        _buildTextField(
                          controller: _codigoController,
                          hint: '000000',
                          icon: Icons.lock_outline,
                          isNumber: true,
                        ),
                        TextButton(
                          onPressed: () => setState(() => _etapa = 0),
                          child: const Text(
                            "Corrigir email",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],

                      // CONTEÚDO (NOVA SENHA)
                      if (_etapa == 2) ...[
                        _buildLabel('Nova Senha'),
                        TextFormField(
                          controller: _novaSenhaController,
                          obscureText: !_senhaVisivel,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '****',
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                            ),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.25),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide.none,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _senhaVisivel
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                                color: Colors.white,
                              ),
                              onPressed: () => setState(
                                () => _senhaVisivel = !_senhaVisivel,
                              ),
                            ),
                          ),
                          validator: (v) => (v != null && v.length < 4)
                              ? 'Mínimo 4 caracteres'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        _buildLabel('Confirmar Nova Senha'),
                        TextFormField(
                          controller: _confirmarSenhaController,
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: '****',
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
                          validator: (v) {
                            if (v != _novaSenhaController.text) {
                              return 'As senhas não coincidem';
                            }
                            return null;
                          },
                        ),
                      ],

                      const SizedBox(height: 24),

                      // BOTÃO DE AÇÃO
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE85C7A),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          onPressed: _pensador,
                          child: Text(
                            _getTextoBotao(),
                            style: const TextStyle(
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
      ),
    );
  }

  Widget _buildLabel(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8),
    child: Text(
      text,
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
  );

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isNumber = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
        filled: true,
        fillColor: Colors.white.withOpacity(0.25),
        suffixIcon: Icon(icon, color: Colors.white),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (v) => v == null || v.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}
