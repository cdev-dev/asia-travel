class Destino {
  final int id;
  final String nombre;
  final String descripcionCorta;
  final String descripcionLarga;
  final String imagenUrl;
  final double precio;
  final int dias;

  Destino({
    required this.id,
    required this.nombre,
    required this.descripcionCorta,
    required this.descripcionLarga,
    required this.imagenUrl,
    required this.precio,
    required this.dias,
  });

  factory Destino.fromJson(Map<String, dynamic> json) {
    final String rutaImagen = json['imagen_destacada'] ?? '';
    final String imagenFinal = rutaImagen.replaceFirst('assets/', '');
    final String urlImagen =
        'https://cdev-dev.github.io/asia-travel-assets/$imagenFinal';

    return Destino(
      id: json['id'],
      nombre: json['nombre'],
      descripcionCorta: json['descripcion_corta'],
      descripcionLarga: json['descripcion_larga'],
      imagenUrl: urlImagen,
      precio: json['precio']?.toDouble() ?? 0, // Asegura que sea double
      dias: json['dias'] ?? 0, // Asegura que no falle si falta
    );
  }
}
