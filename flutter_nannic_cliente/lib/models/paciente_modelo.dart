class Paciente {
  final String? id_paciente;
  final String? nombre;
  final String? email_paciente;
  final String? tel_paciente;
  final String? imagen_paciente;
  final String? fecha_alta;
  final String? activo;
  final String? dato1;
  final String? dato2;
  final String? dato3;
  final String? dato4;
  final String? dato5;


  Paciente({
    this.id_paciente,
    this.nombre,
    this.email_paciente,
    this.tel_paciente,
    this.fecha_alta,
    this.imagen_paciente,
    this.activo,
    this.dato1,
    this.dato2,
    this.dato3,
    this.dato4,
    this.dato5,

  });

  factory Paciente.fromJson(Map<String, dynamic> json) {
    return Paciente(
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      nombre: json['nombre'] != null ? json['nombre'] as String : null,
      email_paciente: json['email_paciente'] != null ? json['email_paciente'] as String : null,
      tel_paciente: json['tel_paciente'] != null ? json['tel_paciente'] as String : null,
      imagen_paciente: json['imagen_paciente'] != null ? json['imagen_paciente'] as String : null,
      activo: json['activo'] != null ? json['activo'] as String : null,
      fecha_alta: json['fecha_alta'] != null ? json['fecha_alta'] as String : null,
      dato1: json['dato1'] != null ? json['dato1'] as String : null,
      dato2: json['dato2'] != null ? json['dato2'] as String : null,
      dato3: json['dato3'] != null ? json['dato3'] as String : null,
      dato4: json['dato4'] != null ? json['dato4'] as String : null,
      dato5: json['dato5'] != null ? json['dato5'] as String : null,


    );
  }
}



