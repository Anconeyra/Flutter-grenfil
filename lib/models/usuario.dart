class Usuario {
  int id;
  String nombre;
  String correo;
  String passwordHash;
  String? direccion;
  String? telefono;
  String? rol;
  DateTime? fechaRegistro;

  Usuario({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.passwordHash,
    this.direccion,
    this.telefono,
    this.rol = "Cliente", // Valor predeterminado
    this.fechaRegistro,
  });

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
      passwordHash: json['passwordHash'],
      direccion: json['direccion'],
      telefono: json['telefono'],
      rol: json['rol'],
      fechaRegistro: json['fechaRegistro'] != null
          ? DateTime.parse(json['fechaRegistro'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'correo': correo,
      'passwordHash': passwordHash,
      'direccion': direccion,
      'telefono': telefono,
      'rol': rol,
      'fechaRegistro': fechaRegistro?.toIso8601String(),
    };
  }
}