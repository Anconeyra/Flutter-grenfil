import 'package:flutter/material.dart';
import '../screens/filament_screen.dart'; // Importa la página Filamentos

class BaseScreen extends StatelessWidget {
  final Widget body;
  final String title;

  const BaseScreen({
    super.key, // Usa super.key
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'GreenFil',
              style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
            ),
            const Spacer(),
            TextButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text(
                'Cerrar Sesión',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 60,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'GreenFil',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.shopping_bag, color: Colors.black),
                title: const Text('Filamentos'),
                onTap: () {
                  // Navega a la página de Filamentos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const FilamentosScreen()), // Usa la clase FilamentosScreen
                    );
                },
              ),
              const ListTile(
                leading: Icon(Icons.print, color: Colors.black),
                title: Text('Servicio de Impresión'),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.help, color: Colors.black),
                title: Text('¿Cómo Usar?'),
                onTap: null,
              ),
              const ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.black),
                title: Text('Carrito'),
                onTap: null,
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}

