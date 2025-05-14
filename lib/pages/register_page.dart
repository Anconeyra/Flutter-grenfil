import 'package:flutter/material.dart';
import '../models/usuario.dart';
import '../services/api_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController direccionController = TextEditingController();
  final TextEditingController telefonoController = TextEditingController();

  final ApiService apiService = ApiService();
  String selectedRol = "Cliente"; // Valor predeterminado para el rol

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'GreenFi - Registro',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              Image.asset(
                'assets/images/logo.png', // Asegúrate de que la imagen esté en la carpeta correcta
                height: 100, // Ajusta la altura según sea necesario
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre',
                  border: OutlineInputBorder(),
                ),
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
              TextField(
                controller: direccionController,
                decoration: const InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: telefonoController,
                decoration: const InputDecoration(
                  labelText: 'Teléfono',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              DropdownButton<String>(
                value: selectedRol,
                items: <String>["Cliente", "Admin"].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedRol = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  final usuario = Usuario(
                    id: 0,
                    nombre: nameController.text.trim(),
                    correo: emailController.text.trim(),
                    passwordHash: passwordController.text.trim(),
                    direccion: direccionController.text.trim(),
                    telefono: telefonoController.text.trim(),
                    rol: selectedRol, // Usar el rol seleccionado
                  );

                  try {
                    final nuevoUsuario = await apiService.postUsuario(usuario);

                    if (!mounted) return; // Verifica si el widget sigue montado
                    if (context.mounted) {
                      _showMessageDialog(
                        context,
                        'Éxito',
                        'Usuario registrado: ${nuevoUsuario.nombre}',
                        true,
                      );
                    }
                  } catch (e) {
                    if (!mounted) return; // Verifica si el widget sigue montado
                    if (context.mounted) {
                      _showMessageDialog(
                        context,
                        'Error',
                        'Error al registrar usuario: $e',
                        false,
                      );
                    }
                  }
                },
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMessageDialog(BuildContext context, String title, String message, bool success) {
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
                if (success) {
                  Navigator.pushReplacementNamed(context, '/login');
                }
              },
              child: Text(success ? 'Ir a Login' : 'Cerrar'),
            ),
          ],
        );
      },
    );
  }
}