class DatosUsuario {
  String id;
  String email;
  String imagen;
  String nombre;
  String apellidos;
  String nivel_usuario;
  String tel;

  DatosUsuario({required this.id,required  this.email,required this.tel, required this.imagen,required  this.nombre,required  this.apellidos, required this.nivel_usuario});

  factory DatosUsuario.fromJson(Map<String, dynamic> json) {
    return DatosUsuario(
      id: json['id'],
      email: json['email'],
      imagen: json['imagen'],
      nombre: json['nombre'],
      apellidos: json['apellidos'],
      tel: json['tel'],
      nivel_usuario: json['nivel_usuario'],
    );
  }
}
