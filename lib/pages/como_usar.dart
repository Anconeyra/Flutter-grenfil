import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../widgets/base_screen.dart'; // Importante para usar BaseScreen

class ComoUsarScreen extends StatelessWidget {
  const ComoUsarScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // Reemplazamos el guión bajo por convención de nombres.
    YoutubePlayerController videoController = YoutubePlayerController(
      initialVideoId: 'dQw4w9WgXcQ', // Ejemplo: ID de un video de Rick Astley
      flags: const YoutubePlayerFlags( // Agregamos const aquí
        autoPlay: false,
        mute: false, // Cambiamos mute a false para activar el sonido
      ),
    );

    return BaseScreen( // Usamos BaseScreen como Scaffold base
      title: 'Cómo usar el filamento',
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Cómo usar nuestro filamento?',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Para obtener los mejores resultados al imprimir con nuestro filamento, te recomendamos seguir los siguientes parámetros:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'Temperatura del extrusor:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                '200°C - 220°C',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                '(Ajusta según tu impresora y la velocidad de impresión)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Temperatura de la cama:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                '60°C - 70°C',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                '(Opcional, pero mejora la adhesión y reduce el warping)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Velocidad de impresión:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                '40 mm/s - 60 mm/s',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                '(Para mejor precisión, usar velocidades más bajas)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Retracción:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'Distancia: 4 - 6 mm',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                'Velocidad: 25 - 40 mm/s',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                '(Evita el goteo y mejora la calidad de las piezas)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 10),
              const Text(
                'Ventilador de capa:',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              ),
              const Text(
                'Activado',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const Text(
                '(Ayuda a enfriar el material rápidamente y mejora los detalles)',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              const SizedBox(height: 20),
              const Text(
                'También te dejamos este video donde podrás observar cómo hacer una impresión correcta:',
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
              const SizedBox(height: 10),
              // Reemplazamos la imagen con el reproductor de Youtube
              YoutubePlayer(
                controller: videoController,
                showVideoProgressIndicator: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

