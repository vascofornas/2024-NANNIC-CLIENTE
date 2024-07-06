class PacienteDatosMedicos {
  final String? id;
  final String? id_paciente;
  final String? alta_presion;
  final String? baja_presion;
  final String? diabetes;
  final String? cardiopatias;
  final String? embarazo;
  final String? marcapasos;
  final String? lentillas;
  final String? epilepsia;
  final String? alergias;
  final String? hormonal_problems;
  final String? medicacion_actual;
  final String? observaciones_datos_medicos;
  final String? implantes_metalicos;
  final String? fecha_actualizacion;



  PacienteDatosMedicos({
    this.id,
    this.id_paciente,
    this.alta_presion,
    this.baja_presion,
    this.diabetes,
    this.cardiopatias,
    this.embarazo,
    this.marcapasos,
    this.lentillas,
    this.epilepsia,
    this.alergias,
    this.hormonal_problems,
    this.medicacion_actual,
    this.observaciones_datos_medicos,
    this.implantes_metalicos,
    this.fecha_actualizacion

  });

  factory PacienteDatosMedicos.fromJson(Map<String, dynamic> json) {
    return PacienteDatosMedicos(
      id: json['id'] != null ? json['id'] as String : null,
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      alta_presion: json['alta_presion'] != null ? json['alta_presion'] as String : null,
      baja_presion: json['baja_presion'] != null ? json['baja_presion'] as String : null,
      diabetes: json['diabetes'] != null ? json['diabetes'] as String : null,
      cardiopatias: json['cardiopatias'] != null ? json['cardiopatias'] as String : null,
      embarazo: json['embarazo'] != null ? json['embarazo'] as String : null,
      marcapasos: json['marcapasos'] != null ? json['marcapasos'] as String : null,
      lentillas: json['lentillas'] != null ? json['lentillas'] as String : null,
      epilepsia: json['epilepsia'] != null ? json['epilepsia'] as String : null,
      alergias: json['alergias'] != null ? json['alergias'] as String : null,
      hormonal_problems: json['hormonal_problems'] != null ? json['hormonal_problems'] as String : null,
      medicacion_actual: json['medicacion_actual'] != null ? json['medicacion_actual'] as String : null,
      implantes_metalicos: json['implantes_metalicos'] != null ? json['implantes_metalicos'] as String : null,
      observaciones_datos_medicos: json['observaciones_datos_medicos'] != null ? json['observaciones_datos_medicos'] as String : null,


    );
  }

}



