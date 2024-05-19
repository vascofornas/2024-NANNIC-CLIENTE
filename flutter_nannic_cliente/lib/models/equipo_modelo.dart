class Equipo {
  final String? id;
  final String? nombre_equipo;
  final String? imagen_equipo;
  final String? fecha_alta;
  final String? num_serie;
  late final String? disponible;



  Equipo({
    this.id,
    this.nombre_equipo,
    this.imagen_equipo,
    this.fecha_alta,
    this.num_serie,
    this.disponible

  });

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      id: json['id'] != null ? json['id'] as String : null,
      nombre_equipo: json['nombre_equipo'] != null ? json['nombre_equipo'] as String : null,
      imagen_equipo: json['imagen_equipo'] != null ? json['imagen_equipo'] as String : null,
      fecha_alta: json['fecha_alta'] != null ? json['fecha_alta'] as String : null,
        num_serie: json['num_serie'] != null ? json['num_serie'] as String : null,
        disponible: json['disponible'] != null ? json['disponible'] as String : null

    );
  }
}



