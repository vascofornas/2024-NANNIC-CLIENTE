class Clinica {
  final String? id;
  final String? nombre_clinica;
  final String? email_clinica;
  final String? direccion_clinica;
  final String? tel_clinica;
  final String? fecha_alta_clinica;
  final String? logo_clinica;
  final String? pais_clinica;


  Clinica({
    this.id,
    this.nombre_clinica,
    this.email_clinica,
    this.tel_clinica,
    this.direccion_clinica,
    this.fecha_alta_clinica,
    this.logo_clinica,
    this.pais_clinica
  });

  factory Clinica.fromJson(Map<String, dynamic> json) {
    return Clinica(
      id: json['id'] != null ? json['id'] as String : null,
      nombre_clinica: json['nombre_clinica'] != null ? json['nombre_clinica'] as String : null,
      email_clinica: json['email_clinica'] != null ? json['email_clinica'] as String : null,
      direccion_clinica: json['direccion_clinica'] != null ? json['direccion_clinica'] as String : null,
      tel_clinica: json['tel_clinica'] != null ? json['tel_clinica'] as String : null,
      fecha_alta_clinica: json['fecha_alta_clinica'] != null ? json['fecha_alta_clinica'] as String : null,
      logo_clinica: json['logo_clinica'] != null ? json['logo_clinica'] as String : null,
      pais_clinica: json['pais_clinica'] != null ? json['pais_clinica'] as String : null,
    );
  }
}



