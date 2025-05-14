// lib/models/transaccion.dart
class Transaccion {
  final int id;
  final int pedidoId;
  final DateTime fechaTransaccion;
  final double monto;

  Transaccion({
    required this.id,
    required this.pedidoId,
    required this.fechaTransaccion,
    required this.monto,
  });

  factory Transaccion.fromJson(Map<String, dynamic> json) {
    return Transaccion(
      id: json['id'],
      pedidoId: json['pedidoId'],
      fechaTransaccion: DateTime.parse(json['fechaTransaccion']),
      monto: json['monto'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pedidoId': pedidoId,
      'fechaTransaccion': fechaTransaccion.toIso8601String(),
      'monto': monto,
    };
  }
}
