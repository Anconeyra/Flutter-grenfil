import 'package:flutter/material.dart';
import '../screens/filament_screen.dart'; // Importa la página Filamentos
import '../pages/como_usar.dart'; // Importa la página ComoUsar
import '../pages/home_page.dart'; // Importa la página Homepage
import '../pages/carrito.dart'; // Importa la página Carrito

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
                leading: const Icon(Icons.home, color: Colors.black),
                title: const Text('Home'),
                onTap: () {
                  // Navega a la página de Homepage
                  Navigator.pushReplacement(
                    // Usa pushReplacement para evitar volver atrás
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        const HomePage(), // Usa la clase HomePage
                    ),
                  );
                },
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
                        const FilamentosScreen(), // Usa la clase FilamentosScreen
                    ),
                  );
                },
              ),
              const ListTile(
                leading: Icon(Icons.print, color: Colors.black),
                title: Text('Servicio de Impresión'),
                onTap: null,
              ),
              ListTile(
                leading: const Icon(Icons.help, color: Colors.black),
                title: const Text('¿Cómo Usar?'),
                onTap: () {
                  // Navega a la página de Como Usar
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                        const ComoUsarScreen(), // Usa la clase ComoUsarPage
                    ),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.shopping_cart, color: Colors.black),
                title: const Text('Carrito'),
                onTap: () {
                  // Navega a la página del Carrito
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CarritoPage(), // Usa la clase CarritoPage
                    ),
                  );
                },
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

