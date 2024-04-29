class Profesional {
  final String? id;
  final String? nombre;
  final String? email;
  final String? tel;
  final String? created_at;
  final String? imagen;
  final String? verified;
  final String? apellidos;
  final String? nivel_usuario;
  final String? activo;
  final String? terms;
  final String? token_firebase;
  final String? cel_verificado;
  final String? so_dispositivo;
  final String? modelo_dispositivo;
  final String? version_app;

  Profesional({
    this.id,
    this.nombre,
    this.email,
    this.tel,
    this.created_at,
    this.imagen,
    this.apellidos,
    this.nivel_usuario,
    this.activo,
    this.terms,
    this.verified,
    this.version_app,
    this.so_dispositivo,
    this.cel_verificado,
    this.token_firebase,
    this.modelo_dispositivo
  });

  factory Profesional.fromJson(Map<String, dynamic> json) {
    return Profesional(
      id: json['id'] != null ? json['id'] as String : null,
      nombre: json['nombre'] != null ? json['nombre'] as String : null,
      email: json['email'] != null ? json['email'] as String : null,
      tel: json['tel'] != null ? json['tel'] as String : null,
      created_at: json['created_at'] != null ? json['created_at'] as String : null,
      imagen: json['imagen'] != null ? json['imagen'] as String : null,
      apellidos: json['apellidos'] != null ? json['apellidos'] as String : null,
      nivel_usuario: json['nivel_usuario'] != null ? json['nivel_usuario'] as String : null,
      activo: json['activo'] != null ? json['activo'] as String : null,
      terms: json['terms'] != null ? json['terms'] as String : null,
      verified: json['verified'] != null ? json['verified'] as String : null,
      version_app: json['version_app'] != null ? json['version_app'] as String : null,
      token_firebase: json['token_firebase'] != null ? json['token_firebase'] as String : null,
      cel_verificado: json['cel_verificado'] != null ? json['cel_verificado'] as String : null,
      so_dispositivo: json['so_dispositivo'] != null ? json['so_dispositivo'] as String : null,
      modelo_dispositivo: json['modelo_dispositivo'] != null ? json['modelo_dispositivo'] as String : null,

    );
  }
}



