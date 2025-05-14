import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // Para codificar los datos en JSON
import '../widgets/base_screen.dart'; // Importa BaseScreen

class AddProductPage extends StatelessWidget {
  AddProductPage({super.key});

  final _formKey = GlobalKey<FormState>();

  // Controladores para los campos del formulario
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _descripcionController = TextEditingController();
  final TextEditingController _precioController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _tipoController = TextEditingController();
  final TextEditingController _imagenUrlController = TextEditingController();

  // URL del backend
  final String apiUrl = "http://10.0.2.2:5088/api/Productos"; // Cambia <tu-servidor> por la URL de tu backend

  // Método para enviar datos al backend
  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final producto = {
        'nombre': _nombreController.text,
        'descripcion': _descripcionController.text,
        'precio': double.parse(_precioController.text),
        'stock': int.parse(_stockController.text),
        'tipo': _tipoController.text,
        'imagen_url': _imagenUrlController.text,
      };

      try {
        final response = await http.post(
          Uri.parse(apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(producto),
        );

        if (response.statusCode == 201) {
          // Verifica si el widget sigue montado antes de usar el contexto
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Producto agregado exitosamente')),
            );
            Navigator.pop(context); // Regresar a la pantalla anterior
          }
        } else {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${response.body}')),
            );
          }
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Error de conexión con el servidor')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Agregar Producto', // Título fijo
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nombreController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el nombre del producto';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
              ),
              TextFormField(
                controller: _precioController,
                decoration: const InputDecoration(labelText: 'Precio'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el precio';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un número válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stock'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el stock';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingresa un número entero válido';
                  }
                  return null;
                },
              ),
              DropdownButtonFormField<String>(
                value: null,
                decoration: const InputDecoration(labelText: 'Tipo'),
                items: const [
                  DropdownMenuItem(
                    value: 'filamento',
                    child: Text('Filamento'),
                  ),
                  DropdownMenuItem(
                    value: 'producto_impreso',
                    child: Text('Producto Impreso'),
                  ),
                ],
                onChanged: (value) {
                  _tipoController.text = value ?? '';
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor selecciona un tipo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imagenUrlController,
                decoration: const InputDecoration(labelText: 'URL de la Imagen'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa una URL válida para la imagen';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () => _submitForm(context), // Llama al método para enviar datos
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: const Text('Agregar Producto'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}