import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/footer.dart'; // Footer personalizado
import '../pages/product_detail_page.dart';
import '../widgets/base_screen.dart';
import '../pages/add_product_page.dart'; // Importa BaseScreen
import '../pages/impresion.dart'; // Importa la página de impresión

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> productos = [];
  final String apiUrl = "http://10.0.2.2:5088/api/Productos";

  @override
  void initState() {
    super.initState();
    _fetchProductos();
  }

  Future<void> _fetchProductos() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        setState(() {
          productos = jsonDecode(response.body);
        });
      } else {
        debugPrint('Error al obtener productos: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error de conexión: $e');
    }
  }

  String _getImageUrl(String? url) {
    if (url == null || url.isEmpty) {
      return 'https://via.placeholder.com/150';
    }
    return url;
  }

  Future<void> _launchWhatsApp() async {
    const whatsappUrlString = "https://wa.me/51947949975";
    final Uri whatsappUri = Uri.parse(whatsappUrlString);
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri);
    } else {
      throw "No se pudo abrir WhatsApp";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'GreenFil', // Establece el título para BaseScreen
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.black,
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Venta de Filamento 3D',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Transforma botellas en ideas. Nuestro filamento PET1 reciclado da vida a tus proyectos 3D.',
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    // Acción catálogo
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  child: const Text('Mira nuestro catálogo'),
                                ),
                                ElevatedButton(
                                  onPressed: _launchWhatsApp,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 10),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.asset(
                                        'assets/images/whatsapp.jpeg',
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(width: 8),
                                      const Text('Haz tu pedido'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ImpresionPage(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 30, vertical: 12),
                                ),
                                child: const Text('Servicios de impresión 3D'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Text('Más Vendidos',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ),
                      productos.isEmpty
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: CircularProgressIndicator(),
                              ),
                            )
                          : GridView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.8,
                              ),
                              itemCount: productos.length,
                              itemBuilder: (context, index) {
                                final producto = productos[index];
                                return Card(
                                  elevation: 4,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                        productId:
                                                            producto['id']),
                                              ),
                                            );
                                          },
                                          child: Image.network(
                                            _getImageUrl(
                                                producto['imagenUrl']),
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                            errorBuilder: (context, error,
                                                stackTrace) {
                                              return const Icon(
                                                  Icons.image_not_supported,
                                                  size: 50);
                                            },
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          producto['nombre'] ?? 'Sin nombre',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Precio: \$${producto['precio'] ?? '0.00'}',
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 142, 223, 142)),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductDetailPage(
                                                        productId:
                                                            producto['id']),
                                              ),
                                            );
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                          ),
                                          child: const Text('Ver más'),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: double.infinity,
                child: Footer(),
              ),
            ],
          ),
          Positioned(
            right: 16.0,
            bottom: 76.0, // Se posiciona para no superponer el Footer
            child: FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddProductPage()),
                );
              },
              backgroundColor: Colors.green,
              child: const Icon(Icons.add),
            ),
          ),
        ],
      ),
    );
  }
}