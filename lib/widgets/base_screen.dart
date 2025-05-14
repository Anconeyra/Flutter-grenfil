import 'package:flutter/material.dart';

class BaseScreen extends StatelessWidget {
  final Widget body; // Contenido principal de la pantalla
  final String title; // Título del encabezado

  const BaseScreen({
    super.key,
    required this.body,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true, // Habilita el ícono del menú para abrir el Drawer
        iconTheme: const IconThemeData(color: Colors.white), // Ícono del menú en blanco
        title: Row(
          children: [
            Image.asset(
              'assets/images/logo.png', // Ruta del logo
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
          color: Colors.white, // Fondo blanco para el Drawer
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
                      'assets/images/logo.png', // Ruta del logo
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
              const ListTile(
                leading: Icon(Icons.shopping_bag, color: Colors.black),
                title: Text('Filamentos'),
                onTap: null, // Acción para "Filamentos"
              ),
              const ListTile(
                leading: Icon(Icons.print, color: Colors.black),
                title: Text('Servicio de Impresión'),
                onTap: null, // Acción para "Servicio de Impresión"
              ),
              const ListTile(
                leading: Icon(Icons.help, color: Colors.black),
                title: Text('¿Cómo Usar?'),
                onTap: null, // Acción para "¿Cómo Usar?"
              ),
              const ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.black),
                title: Text('Carrito'),
                onTap: null, // Acción para "Carrito"
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // Encabezado fijo con el título
          Container(
            color: Colors.black,
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () {
                    Navigator.pop(context); // Navegar hacia atrás
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
          // Contenido desplazable
          Expanded(
            child: Container(
              color: Colors.white, // Fondo blanco para el contenido
              child: body,
            ),
          ),
        ],
      ),
    );
  }
}