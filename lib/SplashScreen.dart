import 'package:confeitaria_app/temporario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

// Adicione 'with SingleTickerProviderStateMixin' para a animação
class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // 1. Crie o Controller e a Animação
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // 2. Configure a Animação
    _controller = AnimationController(
      duration: const Duration(seconds: 2), // Duração da animação (2 seg)
      vsync: this,
    )..repeat(reverse: true); // Repete (indo e voltando)

    // Define o movimento: 15 pixels para cima (0, -15) e 15 para baixo (0, 15)
    _animation =
        Tween<Offset>(
          begin: const Offset(0, -10.0),
          end: const Offset(0, 10.0),
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: Curves.easeInOut, // Curva suave
          ),
        );

    _navigateToHome();
  }

  _navigateToHome() async {
    // Duração total da splash
    await Future.delayed(const Duration(milliseconds: 7000), () {});

    // Navegue para a Home e remova a Splash da pilha
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Temp()),
    );
  }

  @override
  void dispose() {
    // 3. Lembre-se de "limpar" o controller
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(247, 191, 180, 100), // Seu Roxo
              Color.fromRGBO(232, 92, 122, 100), // Seu Lilás
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        // Centralize o conteúdo
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 4. APLIQUE A ANIMAÇÃO AQUI
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  // Transform.translate move o widget
                  return Transform.translate(
                    offset: _animation.value,
                    child: child,
                  );
                },
                // O 'child' é a sua logo (sem o texto)
                child: Image.asset(
                  'assets/logo.png', // <-- Use a imagem SÓ da logo
                  width: 150,
                ),
              ),

              const SizedBox(height: 24), // Espaço entre logo e texto
              // 5. ADICIONE O TEXTO
              const Text(
                "Delícias da Zu",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'jujuGothic', // Fonte personalizada
                ),
              ),

              const SizedBox(height: 8), // Espaço entre textos

              const Text(
                "Descubra sabores inesquecíveis",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70, // Um branco mais suave
                  fontFamily: 'jujuGothic', // Fonte personalizada
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
