import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProductDetailPage extends StatefulWidget {
  final int productId;

  const ProductDetailPage({super.key, required this.productId});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late Future<dynamic> _productoFuture;
  final String _apiBaseUrl = "http://10.0.2.2:5088/api/Productos";
  int _quantity = 1; // Contador para la cantidad

  @override
  void initState() {
    super.initState();
    _productoFuture = _fetchProducto();
  }

  Future<dynamic> _fetchProducto() async {
    try {
      final response = await http.get(Uri.parse("$_apiBaseUrl/${widget.productId}"));
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Error al cargar el producto: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) { // Asegurarse de que la cantidad no sea menor que 1
        setState(() {
          _quantity--;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalles del Producto'),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: _productoFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar el producto',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  Text(
                    snapshot.error.toString(),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _productoFuture = _fetchProducto();
                      });
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No se encontró el producto'));
          }

          final producto = snapshot.data!;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagen del producto
                ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    producto['imagenUrl'] ?? 'https://via.placeholder.com/400',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        height: 300,
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.image_not_supported,
                              size: 50, color: Colors.grey),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 24),
                // Nombre y precio
                Text(
                  producto['nombre'] ?? 'Sin nombre',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Precio: \$${producto['precio']?.toStringAsFixed(2) ?? '0.00'}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                // Tipo y stock
                Row(
                  children: [
                    _buildInfoChip(
                      icon: Icons.category,
                      text: producto['tipo'] ?? 'Sin tipo',
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      icon: Icons.inventory,
                      text: 'Stock: ${producto['stock']?.toString() ?? '0'}',
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                // Descripción
                const Text(
                  'Descripción:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  producto['descripcion'] ?? 'No hay descripción disponible',
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 32),
                // Contador y botón de añadir al carrito
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: _decrementQuantity,
                        ),
                        Text(
                          '$_quantity',
                          style: const TextStyle(fontSize: 20),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: _incrementQuantity,
                        ),
                      ],
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Lógica para añadir al carrito
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('$_quantity Producto(s) añadido(s) al carrito'),
                            duration: const Duration(seconds: 2),
                          ),
                        );
                      },
                      
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24), // Ajusta el padding horizontal
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                      icon: const Icon(Icons.shopping_cart, color: Colors.white),
                      label: const Text(
                        'Añadir al carrito',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoChip({required IconData icon, required String text}) {
    return Chip(
      avatar: Icon(icon, size: 18),
      label: Text(text),
      backgroundColor: Colors.grey[200],
      visualDensity: VisualDensity.compact,
    );
  }
}
