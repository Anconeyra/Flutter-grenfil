import 'package:flutter/material.dart';

class ConsejosScreen extends StatelessWidget {
  const ConsejosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Consejos y soluciones')),
      body: const Center(child: Text('Contenido de Consejos y soluciones')),
    );
  }
}