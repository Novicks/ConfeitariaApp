import 'package:confeitaria_app/temporario.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<Offset>(
      begin: const Offset(0, -10.0),
      end: const Offset(0, 10.0),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 5000), () {});

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Temp()),
    );
  }

  @override
  void dispose() {
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
              Color.fromRGBO(247, 191, 180, 100),
              Color.fromRGBO(232, 92, 122, 100),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.translate(
                    offset: _animation.value,
                    child: child,
                  );
                },
                child: Image.asset('assets/logo.png', width: 150),
              ),

              const SizedBox(height: 24),
              const Text(
                "Delícias da Zu",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'jujuGothic',
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                "Descubra sabores inesquecíveis",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                  fontFamily: 'jujuGothic',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
