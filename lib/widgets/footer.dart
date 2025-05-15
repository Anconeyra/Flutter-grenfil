import 'package:flutter/material.dart';
import '../pages/como_usar.dart'; // Importa ti ComoUsarScreen
import '../pages/consejos.dart'; // Importa ti ConsejosScreen
import '../pages/direccion.dart'; // Importa ti DireccionScreen

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pedidos:',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '+51 957869656',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Mapan iti ComoUsarScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ComoUsarScreen()),
                      );
                    },
                    child: const Text(
                      'Cómo usar el filamento',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Mapan iti ConsejosScreen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConsejosScreen()),
                      );
                    },
                    child: const Text(
                      'Consejos y soluciones',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  // Mapan iti DireccionScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DireccionScreen()),
                  );
                },
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Horario de Atención:',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Lunes a Viernes: 10:00 AM a 5:00 PM UTC',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    Text(
                      'Sábados: 10:00 AM a 1:00 AM UTC',
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
