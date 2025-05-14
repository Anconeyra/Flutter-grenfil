import 'package:flutter/material.dart';
import '../widgets/base_screen.dart'; // Importamos BaseScreen

class ConsejosScreen extends StatelessWidget {
  const ConsejosScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BaseScreen( // Usamos BaseScreen en lugar de Scaffold
      title: 'Consejos y soluciones',
      body: Padding( // Añadimos Padding para el contenido principal
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView( // Añadido SingleChildScrollView
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Alineamos el contenido a la izquierda
            children: [
              const Text(
                'Consejos & Soluciones de Problemas', // Título principal
                style: TextStyle(
                  fontSize: 20, // Tamaño de fuente más grande
                  fontWeight: FontWeight.bold, // Texto en negrita
                  color: Colors.black, // Color del texto
                ),
              ),
              const SizedBox(height: 20), // Espacio entre el título y el primer problema
              _buildProblemSection(
                title: 'Problemas Comunes:',
                problems: const [
                  'Warping (despegue de esquinas)',
                  'Stringing (hilos entre zonas)',
                  'Under-extrusion (poca salida de filamento)',
                  // Agrega aquí más problemas comunes si los hay
                ],
              ),
              const SizedBox(height: 20), // Espacio antes del primer problema detallado
              _buildWarpingSection(),
              const SizedBox(height: 20),
              _buildStringingSection(),
              const SizedBox(height: 20),
              _buildUnderExtrusionSection(),
              // Agrega aquí más secciones de problemas detallados si los hay
            ],
          ),
        ),
      ),
    );
  }

  // Función para construir la sección de un problema común
  Widget _buildProblemSection({required String title, required List<String> problems}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: problems.map((problem) => Text('• $problem', style: const TextStyle(fontSize: 16, color: Colors.black))).toList(),
        ),
      ],
    );
  }

  // Función para construir la sección detallada de Warping
  Widget _buildWarpingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Warping (despegue de esquinas)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Causa: La pieza se enfría demasiado rápido o la cama no tiene buena adherencia.',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 8),
        const Text(
          'Solución:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        const Text('• Usa cama caliente (60-70 °C para PLA)', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Añade brim o raft', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Usa adhesivos (pegamento en barra, laca, etc.)', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Evita corrientes de aire en el área de impresión', style: TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 10),
        Center(
          child: Image.asset('assets/images/logo.png', height: 200), // Asegúrate de que la ruta de la imagen sea correcta
        ),
      ],
    );
  }

  // Función para construir la sección detallada de Stringing
  Widget _buildStringingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Stringing (hilos entre zonas)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Causa: Retracción mal ajustada o temperatura demasiado alta.',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 8),
        const Text(
          'Solución:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        const Text('• Aumenta la distancia o velocidad de retracción', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Reduce un poco la temperatura del extrusor', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Activa el ventilador de capa', style: TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 10),
        Center(
          child: Image.asset('assets/images/logo.png', height: 200), // Asegúrate de que la ruta de la imagen sea correcta
        ),
      ],
    );
  }

  Widget _buildUnderExtrusionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Under-extrusion (poca salida de filamento)',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Causa: Boquilla parcialmente obstruida, problemas con el extrusor, o flujo de material incorrecto.',
          style: TextStyle(fontSize: 16, color: Colors.black),
        ),
        const SizedBox(height: 8),
        const Text(
          'Solución:',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        const Text('• Limpia la boquilla (cold pull, aguja)', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Verifica la tensión del extrusor', style: TextStyle(fontSize: 16, color: Colors.black)),
        const Text('• Calibra el flujo de material (ajuste del extrusor multiplier)', style: TextStyle(fontSize: 16, color: Colors.black)),
        const SizedBox(height: 10),
        Center(
          child: Image.asset('assets/images/logo.png', height: 200), // Asegúrate de que la ruta de la imagen sea correcta
        ),
      ],
    );
  }
}

