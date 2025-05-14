class Producto {
  final int? id;
  final String nombre;
  final String? descripcion;
  final double precio;
  final int stock;
  final String tipo;
  final String? imagenUrl;
  final DateTime? creadoEn;

  Producto({
    this.id,
    required this.nombre,
    this.descripcion,
    required this.precio,
    required this.stock,
    required this.tipo,
    this.imagenUrl,
    this.creadoEn,
  });

  // Método para convertir un mapa (JSON) a un objeto Producto
  factory Producto.fromJson(Map<String, dynamic> json) {
    return Producto(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: json['precio'],
      stock: json['stock'],
      tipo: json['tipo'],
      imagenUrl: json['imagen_url'],
      creadoEn: json['creado_en'] != null
          ? DateTime.parse(json['creado_en'])
          : null,
    );
  }

  // Método para convertir un objeto Producto a un mapa (JSON)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'descripcion': descripcion,
      'precio': precio,
      'stock': stock,
      'tipo': tipo,
      'imagen_url': imagenUrl,
      'creado_en': creadoEn?.toIso8601String(),
    };
  }
}