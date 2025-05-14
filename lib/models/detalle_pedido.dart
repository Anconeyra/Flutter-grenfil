class DetallePedido {
  final int id;
  final int pedidoId;
  final int productoId;
  final int cantidad;
  final double subtotal;

  DetallePedido({
    required this.id,
    required this.pedidoId,
    required this.productoId,
    required this.cantidad,
    required this.subtotal,
  });

  factory DetallePedido.fromJson(Map<String, dynamic> json) {
    return DetallePedido(
      id: json['id'],
      pedidoId: json['pedidoId'],
      productoId: json['productoId'],
      cantidad: json['cantidad'],
      subtotal: json['subtotal'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pedidoId': pedidoId,
      'productoId': productoId,
      'cantidad': cantidad,
      'subtotal': subtotal,
    };
  }
}