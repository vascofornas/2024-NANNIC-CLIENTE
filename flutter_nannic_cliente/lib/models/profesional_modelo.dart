class Profesional {
  final String? id;
  final String? nombre;
  final String? email;
  final String? tel;

  final String? created_at;
  final String? imagen;
  final String? apellidos;
  final String? nivel_usuario;
  final String? activo;
  final String? terms;
  final String? push_todas;
  final String? push_comunicados;
  final String? push_foros;
  final String? push_agenda;
  final String? push_sat;
  final String? push_tienda;
  final String? grupo_tm;
  final String? grupo_me;
  final String? grupo_bc;
  final String? grupo_be;
  final String? grupo_administradores;
  final String? tipo_disp;
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
    this.push_todas,
    this.push_comunicados,
    this.push_foros,
    this.push_agenda,
    this.push_sat,
    this.push_tienda,
    this.grupo_tm,
    this.grupo_me,
    this.grupo_bc,
    this.grupo_be,
    this.grupo_administradores,
    this.tipo_disp,
    this.version_app
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
      push_todas: json['push_todas'] != null ? json['push_todas'] as String : null,
      push_comunicados: json['push_comunicados'] != null ? json['push_comunicados'] as String : null,
      push_agenda: json['push_agenda'] != null ? json['push_agenda'] as String : null,
      push_foros: json['push_foros'] != null ? json['push_foros'] as String : null,
      push_sat: json['push_sat'] != null ? json['push_sat'] as String : null,
      push_tienda: json['push_tienda'] != null ? json['push_tienda'] as String : null,
      grupo_tm: json['grupo_tm'] != null ? json['grupo_tm'] as String : null,
      grupo_me: json['grupo_me'] != null ? json['grupo_me'] as String : null,
      grupo_bc: json['grupo_bc'] != null ? json['grupo_bc'] as String : null,
      grupo_be: json['grupo_be'] != null ? json['grupo_be'] as String : null,
      grupo_administradores: json['grupo_administradores'] != null ? json['grupo_administradores'] as String : null,
      tipo_disp: json['tipo_disp'] != null ? json['tipo_disp'] as String : null,
      version_app: json['version_app'] != null ? json['version_app'] as String : null,

    );
  }
}



