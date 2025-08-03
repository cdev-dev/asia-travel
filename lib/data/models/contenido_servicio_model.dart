class Servicio {
  final int idServicio;
  final String descripcion;
  final String imagen;

  Servicio({
    required this.idServicio,
    required this.descripcion,
    required this.imagen,
  });

  factory Servicio.fromJson(Map<String, dynamic> json) {
    return Servicio(
      idServicio: json['id_servicio'],
      descripcion: json['descripcion'],
      imagen: 'https://cdev-dev.github.io/asia-travel-assets/${json['imagen']}',
    );
  }
}
