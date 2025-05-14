import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'dart:convert';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Logger logger = Logger(); // Instancia de Logger

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'GreenFi',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            Image.asset(
              'assets/images/logo.png', // Asegúrate de que la imagen esté en la carpeta correcta
              height: 100, // Ajusta la altura según sea necesario
            ),
            const SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Contraseña',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final email = emailController.text.trim();
                final password = passwordController.text.trim();

                if (email.isEmpty || password.isEmpty) {
                  _showMessageDialog(
                    context,
                    'Error',
                    'Por favor, completa todos los campos.',
                  );
                  return;
                }

                // Validar credenciales con el backend
                final isValid = await _checkCredentials(email, password);

                if (isValid) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, '/home'); // Navega a HomePage
                  }
                } else {
                  if (context.mounted) {
                    _showMessageDialog(
                      context,
                      'Error',
                      'Correo o contraseña incorrectos.',
                    );
                  }
                }
              },
              child: const Text('Iniciar Sesión'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: const Text('¿No tienes cuenta? Regístrate'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> _checkCredentials(String email, String password) async {
    try {
      // URL del endpoint de inicio de sesión en el backend
      const String url = 'http://10.0.2.2:5088/api/Auth/Login';

      // Enviar solicitud POST al backend
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'correo': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        // Credenciales válidas
        return true;
      } else if (response.statusCode == 401) {
        // Credenciales inválidas
        logger.w('Credenciales inválidas: $email');
        return false;
      } else {
        // Otro error del servidor
        logger.e('Error del servidor: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Manejar errores de conexión o del servidor
      logger.e('Error al validar credenciales', e);
      return false;
    }
  }

  void _showMessageDialog(BuildContext context, String title, String message) {
    if (!context.mounted) return; // Verifica si el contexto sigue montado
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}