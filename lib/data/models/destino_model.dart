class Destino {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagenUrl;

  Destino({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    final String rutaImagen = json['imagen_destacada'];
    final String urlImagen =
        'https://cdev-dev.github.io/asia-travel-assets/${rutaImagen.replaceFirst('assets/', '')}';

    return Destino(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: urlImagen,
    );
  }
}
