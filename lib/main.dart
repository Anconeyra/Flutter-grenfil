import 'package:flutter/material.dart';
import 'pages/login_page.dart';
import 'pages/register_page.dart';
import 'pages/home_page.dart';
import 'pages/add_product_page.dart';
import 'screens/splash_screen/splash_screen.dart'; // Importa la SplashScreen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GreenFi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.routeName, // Establece la SplashScreen como la pantalla inicial
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(), // Ruta para la SplashScreen
        '/login': (context) => LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/add_product': (context) => AddProductPage(),
      },
    );
  }
}