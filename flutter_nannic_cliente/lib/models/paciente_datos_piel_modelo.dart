class PacienteDatosPiel {
  final String? id;
  final String? id_paciente;
  final String? skin_type;
  final String? pores;
  final String? reactivity;
  final String? blood_flow;
  final String? sensitivity;
  final String? excessive_hair;
  final String? sensitivity_uv;

  final String? comentarios_skin;

  final String? fecha_actualizacion;




  PacienteDatosPiel({
    this.id,
    this.id_paciente,
    this.skin_type,
    this.pores,
    this.reactivity,
    this.blood_flow,
    this.sensitivity,
    this.excessive_hair,
    this.sensitivity_uv,
    this.comentarios_skin,
    this.fecha_actualizacion




  });

  factory PacienteDatosPiel.fromJson(Map<String, dynamic> json) {
    return PacienteDatosPiel(
      id: json['id'] != null ? json['id'] as String : null,
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      skin_type: json['skin_type'] != null ? json['skin_type'] as String : null,
      pores: json['pores'] != null ? json['pores'] as String : null,
      reactivity: json['reactivity'] != null ? json['reactivity'] as String : null,
      blood_flow: json['blood_flow'] != null ? json['blood_flow'] as String : null,
      sensitivity: json['sensitivity'] != null ? json['sensitivity'] as String : null,
      excessive_hair: json['excessive_hair'] != null ? json['excessive_hair'] as String : null,
      sensitivity_uv: json['sensitivity_uv'] != null ? json['sensitivity_uv'] as String : null,
      comentarios_skin: json['comentarios_skin'] != null ? json['comentarios_skin'] as String : null,



    );
  }

}



