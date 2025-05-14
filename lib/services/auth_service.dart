import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/usuario.dart';

class AuthService {
  final String baseUrl = 'http://10.0.2.2:5088/api'; // Cambia esto según tu servidor

  Future<Usuario?> login(String correo, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'correo': correo, 'password': password}),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Usuario.fromJson(data);
    } else {
      throw Exception('Error al iniciar sesión: ${response.body}');
    }
  }
}