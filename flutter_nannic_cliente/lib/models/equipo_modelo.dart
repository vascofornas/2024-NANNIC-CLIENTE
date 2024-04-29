class Equipo {
  final String? id;
  final String? nombre_equipo;
  final String? imagen_equipo;



  Equipo({
    this.id,
    this.nombre_equipo,
    this.imagen_equipo,

  });

  factory Equipo.fromJson(Map<String, dynamic> json) {
    return Equipo(
      id: json['id'] != null ? json['id'] as String : null,
      nombre_equipo: json['nombre_equipo'] != null ? json['nombre_equipo'] as String : null,
      imagen_equipo: json['imagen_equipo'] != null ? json['imagen_equipo'] as String : null,

    );
  }
}



