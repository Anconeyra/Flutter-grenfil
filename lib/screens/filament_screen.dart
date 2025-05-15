import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../widgets/base_screen.dart'; // Importa el BaseScreen
import '../pages/product_detail_page.dart'; // Importa la página de detalles del producto

class FilamentosScreen extends StatefulWidget {
  const FilamentosScreen({super.key});

  @override
  _FilamentosScreenState createState() => _FilamentosScreenState();
}

class _FilamentosScreenState extends State<FilamentosScreen> {
  final String _apiUrl = "http://10.0.2.2:5088/api/Productos";
  // La lista de productos obtenidos de la API.
  List<dynamic> _productos = [];
  // Indica si los datos se están cargando.
  bool _isLoading = true;
  // Almacena cualquier error que ocurra durante la carga de datos.
  String _error = '';
  // Controlador para el campo de búsqueda.
  final TextEditingController _searchController = TextEditingController();

  // Función para obtener los productos de la API.
  Future<void> _getProductos() async {
    try {
      final response = await http.get(Uri.parse(_apiUrl)); // Obtiene la respuesta de la API.
      if (response.statusCode == 200) {
        // Si la respuesta es exitosa (código 200), actualiza el estado con los datos.
        _productos = json.decode(response.body); // Decodifica la respuesta JSON.
        _isLoading = false; // Indica que la carga ha terminado.
        _error = ''; // Limpia cualquier error anterior.
      } else {
        // Si la respuesta no es exitosa, actualiza el estado con el código de error.
        _isLoading = false;
        _error = 'Error al cargar los productos: ${response.statusCode}';
      }
    } catch (e) {
      // Si ocurre un error durante la conexión o el procesamiento, actualiza el estado con el error.
      _isLoading = false;
      _error = 'Error de conexión: $e';
    } finally {
      if (mounted) {
        setState(() {}); // Asegura que el setState solo se llama si el widget está montado.
      }
    }
  }

  @override
  void initState() {
    super.initState();
    _getProductos(); // Llama a la función para obtener los productos al inicializar el estado.
  }

  @override
  void dispose() {
    _searchController.dispose(); // Libera los recursos del controlador del campo de búsqueda.
    super.dispose();
  }

  // Función para filtrar los productos según la consulta de búsqueda.
  List<dynamic> _filterProductos(String query) {
    if (query.isEmpty) {
      return _productos; // Si la consulta está vacía, devuelve todos los productos.
    }
    final String lowerCaseQuery = query.toLowerCase(); // Convierte la consulta a minúsculas para la comparación.
    return _productos.where((producto) {
      // Filtra los productos cuyo nombre contiene la consulta (insensible a mayúsculas/minúsculas).
      final String nombre = producto['nombre'].toLowerCase();
      return nombre.contains(lowerCaseQuery);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    // En lugar de Scaffold, usa BaseScreen
    return BaseScreen(
      title: 'Filamentos', // Título de la pantalla.
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Aumenta el padding para mayor espacio
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText( // Usa RichText para aplicar diferentes estilos a diferentes partes del texto
                  text: const TextSpan(
                    style: TextStyle(fontSize: 16, color: Colors.black87), // Estilo por defecto
                    children: <TextSpan>[
                      TextSpan(text: 'En GreenFil te ofrecemos un '),
                      TextSpan(text: 'filamento único', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green)), // Resalta "filamento único"
                      TextSpan(text: ', hecho a base de botellas PET recicladas. Ideal para tus proyectos de impresión 3D, disponible en distintos colores para que tus ideas cobren vida con estilo.'),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 16), // Aumenta el espacio antes del TextField
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar Filamentos',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder( // Añade un borde al TextField para mejor apariencia
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    focusedBorder: OutlineInputBorder( // Estilo del borde cuando el TextField está enfocado
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: const BorderSide(color: Colors.green, width: 2.0), // Borde verde y más grueso
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Ajusta el padding del contenido
                  ),
                  onChanged: (value) {
                    setState(() {});
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildProductList(),
          ),
        ],
      ),
    );
  }

  // Función para construir la lista de productos.
  Widget _buildProductList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (_error.isNotEmpty) {
      return Center(child: Text(_error));
    } else if (_productos.isEmpty) {
      return const Center(child: Text('No hay filamentos disponibles.'));
    } else {
      final List<dynamic> filteredProductos =
          _filterProductos(_searchController.text);
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: filteredProductos.length,
        itemBuilder: (context, index) {
          final producto = filteredProductos[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.zero,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: producto['imagenUrl'] != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              producto['imagenUrl'],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(child: Icon(Icons.error));
                              },
                            ),
                          )
                        : const Center(child: Text('No Image')),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    producto['nombre'],
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Precio: \$${producto['precio'].toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                              productId: producto['id']), // Pasa el ID del producto
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: const TextStyle(fontSize: 12),
                    ),
                    child: const Text('Ver más'),
                  ),
                ],
              ),
            ),
          );
        },
      );
    }
  }
}

