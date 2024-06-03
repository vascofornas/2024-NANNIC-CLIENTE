class PacienteDatosBasicos {
  final String? id;
  final String? id_paciente;
  final String? direccion;
  final String? genero;
  final String? idioma;
  final String? fecha_nacimiento;



  PacienteDatosBasicos({
    this.id,
    this.id_paciente,
    this.direccion,
    this.genero,
    this.idioma,
    this.fecha_nacimiento

  });

  factory PacienteDatosBasicos.fromJson(Map<String, dynamic> json) {
    return PacienteDatosBasicos(
      id: json['id'] != null ? json['id'] as String : null,
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      direccion: json['direccion'] != null ? json['direccion'] as String : null,
      genero: json['genero'] != null ? json['genero'] as String : null,
      idioma: json['idioma'] != null ? json['idioma'] as String : null,
      fecha_nacimiento: json['fecha_nacimiento'] != null && json['fecha_nacimiento'] != '0000-00-00'
          ? json['fecha_nacimiento'] as String
          : 'Fecha no disponible', // O cualquier otro valor predeterminado que desees usar
    );
  }

}



