// lib/models/pedido.dart
import 'usuario.dart';

class Pedido {
  int id;
  int usuarioId;
  DateTime? fecha;
  String? estado;
  double total;
  Usuario usuario;

  Pedido({
    required this.id,
    required this.usuarioId,
    this.fecha,
    this.estado,
    required this.total,
    required this.usuario,
  });

  factory Pedido.fromJson(Map<String, dynamic> json) {
    return Pedido(
      id: json['id'],
      usuarioId: json['usuarioId'],
      fecha: json['fecha'] != null ? DateTime.parse(json['fecha']) : null,
      estado: json['estado'],
      total: (json['total'] as num).toDouble(),
      usuario: Usuario.fromJson(json['usuario']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'usuarioId': usuarioId,
        'fecha': fecha?.toIso8601String(),
        'estado': estado,
        'total': total,
        'usuario': usuario.toJson(),
      };
}
