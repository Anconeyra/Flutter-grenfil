import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import '../models/detalle_pedido.dart';
import '../models/pedido.dart';
import '../models/transaccion.dart';
import '../models/usuario.dart';

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:5088/api'; // Cambia esto según tu servidor
  final Logger logger = Logger(); // Instancia de Logger

  // Métodos para DetallesPedido
  Future<List<DetallePedido>> getDetallesPedido() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/DetallePedido'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => DetallePedido.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar detalles de pedido: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en getDetallesPedido', e);
      rethrow;
    }
  }

  Future<DetallePedido> postDetallePedido(DetallePedido detalle) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/DetallePedido'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(detalle.toJson()),
      );

      if (response.statusCode == 201) {
        return DetallePedido.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al crear detalle pedido: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en postDetallePedido', e);
      rethrow;
    }
  }

  // Métodos para Pedidos
  Future<List<Pedido>> getPedidos() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Pedidos'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Pedido.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar pedidos: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en getPedidos', e);
      rethrow;
    }
  }

  Future<Pedido> postPedido(Pedido pedido) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Pedidos'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(pedido.toJson()),
      );

      if (response.statusCode == 201) {
        return Pedido.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al crear pedido: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en postPedido', e);
      rethrow;
    }
  }

  // Métodos para Transacciones
  Future<List<Transaccion>> getTransacciones() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Transacciones'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Transaccion.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar transacciones: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en getTransacciones', e);
      rethrow;
    }
  }

  Future<Transaccion> postTransaccion(Transaccion transaccion) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Transacciones'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaccion.toJson()),
      );

      if (response.statusCode == 201) {
        return Transaccion.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al crear transacción: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en postTransaccion', e);
      rethrow;
    }
  }

  // Métodos para Usuarios
  Future<List<Usuario>> getUsuarios() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/Usuarios'));

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse.map((item) => Usuario.fromJson(item)).toList();
      } else {
        throw Exception('Error al cargar usuarios: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en getUsuarios', e);
      rethrow;
    }
  }

  Future<Usuario> postUsuario(Usuario usuario) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/Usuarios'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(usuario.toJson()),
      );

      if (response.statusCode == 201) {
        return Usuario.fromJson(json.decode(response.body));
      } else {
        throw Exception('Error al crear usuario: ${response.body}');
      }
    } catch (e) {
      logger.e('Error en postUsuario', e);
      rethrow;
    }
  }
}