class Tour {
  final int id;
  final int destinoId;
  final String titulo;
  final String descripcionCorta;
  final String imagenUrl;
  final double precio;
  final String duracion;

  Tour({
    required this.id,
    required this.destinoId,
    required this.titulo,
    required this.descripcionCorta,
    required this.imagenUrl,
    required this.precio,
    required this.duracion,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    final String rutaImagen = json['imagen_destacada'] ?? '';
    final String imagenFinal = rutaImagen.replaceFirst('assets/images/', '');
    final String urlImagen =
        'https://cdev-dev.github.io/asia-travel-assets/images/destinos/$imagenFinal';

    return Tour(
      id: json['id'] ?? 0,
      destinoId: json['destino_id'] ?? 0,
      titulo: json['titulo'] ?? '',
      descripcionCorta: json['descripcion_corta'] ?? '',
      imagenUrl: urlImagen,
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
      duracion: json['duracion'] ?? '',
    );
  }
}
