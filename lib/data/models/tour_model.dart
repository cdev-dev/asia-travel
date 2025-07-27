class Tour {
  final int id;
  final String nombre;
  final String descripcion;
  final String imagenUrl;
  final double precio;
  final int dias;

  Tour({
    required this.id,
    required this.nombre,
    required this.descripcion,
    required this.imagenUrl,
    required this.precio,
    required this.dias,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    final String rutaImagen = json['imagen_destacada'];
    final String urlImagen =
        'https://cdev-dev.github.io/asia-travel-assets/${rutaImagen.replaceFirst('assets/', '')}';

    return Tour(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      imagenUrl: urlImagen,
      precio: json['precio']?.toDouble() ?? 0.0, // Asegura que sea double
      dias: json['dias'] ?? 0, // Asegura que no falle si falta
    );
  }
}
