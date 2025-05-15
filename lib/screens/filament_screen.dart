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
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController, // Asigna el controlador al campo de texto.
              decoration: const InputDecoration(
                labelText: 'Buscar Filamentos', // Etiqueta del campo de texto.
                hintText: 'Ingrese nombre del filamento', // Texto de sugerencia.
                prefixIcon: Icon(Icons.search), // Icono de búsqueda.
              ),
              onChanged: (value) {
                // Llama a setState para reconstruir el widget con los productos filtrados
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: _buildProductList(), // Muestra la lista de productos.
          ),
        ],
      ),
    );
  }

  // Función para construir la lista de productos.
  Widget _buildProductList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator()); // Muestra un indicador de carga mientras se obtienen los datos.
    } else if (_error.isNotEmpty) {
      return Center(child: Text(_error)); // Muestra un mensaje de error si ocurre alguno.
    } else if (_productos.isEmpty) {
      return const Center(child: Text('No hay filamentos disponibles.')); // Muestra un mensaje si no hay productos.
    } else {
      final List<dynamic> filteredProductos =
          _filterProductos(_searchController.text); // Filtra los productos según la consulta.
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

