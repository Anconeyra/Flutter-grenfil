import 'package:flutter/material.dart';
import 'widgets/animated_logo.dart'; // Importa el widget del logo animado

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';

  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simula una carga de datos o alguna inicialización
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        // Navega a la siguiente pantalla (reemplaza '/home' con tu ruta real)
        Navigator.pushReplacementNamed(context, '/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedLogo(imagePath: 'assets/images/logo.png', height: 150),
            SizedBox(height: 20),
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}