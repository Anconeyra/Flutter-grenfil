import 'package:flutter/material.dart';
import '../widgets/base_screen.dart'; // Importa el BaseScreen

class DireccionScreen extends StatelessWidget {
  const DireccionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Encuéntranos Aquí',// Color de AppBar
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Añadido para hacer la página desplazable
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Dirección',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Calle Manco Segundo 2609 Lince - Lima',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'A 3 cuadras de Vivanda de Av. 2 de mayo',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Entre cuadras 13 y 14 de Av. Javier Prado Oeste',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Teléfonos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Impresiones: +51 972 981 772',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Filamentos y Resinas: +51 972 981 339',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Horario de Atención',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'De Lunes a Viernes de 9:00 a 18:00',
                style: TextStyle(fontSize: 16),
              ),
              const Text(
                'Sábados de 9:00 a 14:00',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              // Imagen del mapa (reemplaza la ruta si es necesario)
              Image.asset(
                'assets/images/image.png', // Asegúrate de que la ruta es correcta
                width: double.infinity,
                fit: BoxFit.fitWidth, // Para que la imagen se ajuste al ancho
              ),
            ],
          ),
        ),
      ),
    );
  }
}

