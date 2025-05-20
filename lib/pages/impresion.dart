import 'package:flutter/material.dart';
import '../widgets/footer.dart';
import '../widgets/base_screen.dart';

class ImpresionPage extends StatelessWidget {
  const ImpresionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Servicio de impresión 3D',
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'En GreenFil ofrecemos un servicio de impresión 3D con los mejores insumos y tecnología para que tus proyectos salgan a la perfección.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      children: [
                        _buildCategoryCard(
                          context,
                          'assets/images/anime.jpg',
                          'Anime',
                        ),
                        _buildCategoryCard(
                          context,
                          'assets/images/star_wars.jpg',
                          'Star wars',
                        ),
                        _buildCategoryCard(
                          context,
                          'assets/images/marvel.jpg',
                          'Marvel',
                        ),
                        _buildCategoryCard(
                          context,
                          'assets/images/macetitas.jpg',
                          'Macetas',
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Acción para "¿Cómo imprimir?"
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purple,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('¿Cómo imprimir?'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const Footer(),
        ],
      ),
    );
  }

  Widget _buildCategoryCard(BuildContext context, String imagePath, String title) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}