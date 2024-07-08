class PacienteDatosHabitos {
  final String? id;
  final String? id_paciente;
  final String? suplementos_alimenticios;
  final String? tipo_alimentacion;
  final String? fuma;
  final String? bebe_alcohol;
  final String? desorden_alimenticio;
  final String? trastorno_sueno;
  final String? bronceado;

  final String? observaciones_costumbres;

  final String? fecha_actualizacion;
  final String? circunstancias_laborales_especificas;



  PacienteDatosHabitos({
    this.id,
    this.id_paciente,
    this.suplementos_alimenticios,
    this.tipo_alimentacion,
    this.fuma,
    this.bebe_alcohol,
    this.desorden_alimenticio,
    this.trastorno_sueno,
    this.bronceado,
    this.circunstancias_laborales_especificas,

    this.observaciones_costumbres,

    this.fecha_actualizacion

  });

  factory PacienteDatosHabitos.fromJson(Map<String, dynamic> json) {
    return PacienteDatosHabitos(
      id: json['id'] != null ? json['id'] as String : null,
      id_paciente: json['id_paciente'] != null ? json['id_paciente'] as String : null,
      suplementos_alimenticios: json['suplementos_alimenticios'] != null ? json['suplementos_alimenticios'] as String : null,
      tipo_alimentacion: json['tipo_alimentacion'] != null ? json['tipo_alimentacion'] as String : null,
      fuma: json['fuma'] != null ? json['fuma'] as String : null,
      bebe_alcohol: json['bebe_alcohol'] != null ? json['bebe_alcohol'] as String : null,
      desorden_alimenticio: json['desorden_alimenticio'] != null ? json['desorden_alimenticio'] as String : null,
      trastorno_sueno: json['trastorno_sueno'] != null ? json['trastorno_sueno'] as String : null,
      bronceado: json['bronceado'] != null ? json['bronceado'] as String : null,
      circunstancias_laborales_especificas: json['circunstancias_laborales_especificas'] != null ? json['circunstancias_laborales_especificas'] as String : null,


      observaciones_costumbres: json['observaciones_costumbres'] != null ? json['observaciones_costumbres'] as String : null,


    );
  }

}



