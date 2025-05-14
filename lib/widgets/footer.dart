import 'package:flutter/material.dart';
import '../pages/como_usar.dart'; // Importa la pantalla ComoUsarScreen
import '../pages/consejos.dart'; // Importa la pantalla ConsejosScreen

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
                      // Navegar a la pantalla de "Cómo usar el filamento"
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ComoUsarScreen()),
                      );
                    },
                    child: const Text(
                      'Cómo usar el filamento',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navegar a la pantalla de "Consejos y soluciones"
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const ConsejosScreen()),
                      );
                    },
                    child: const Text(
                      'Consejos y soluciones',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              const Text(
                'Horario de Atención:',
                style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const Text(
                'Lunes a Viernes: 10:00 AM a 5:00 PM UTC',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              const Text(
                'Sábados: 10:00 AM a 1:00 AM UTC',
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
