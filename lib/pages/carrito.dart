import 'package:flutter/material.dart';

class CarritoPage extends StatelessWidget {
  const CarritoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Carrito'),
        backgroundColor: Colors.black,
      ),
      body: const Center(
        child: Text(
          'Aquí se mostrará el contenido del carrito.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
