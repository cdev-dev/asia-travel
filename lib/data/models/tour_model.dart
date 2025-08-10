class RutaViaje {
  final int dia;
  final String titulo;
  final String descripcion;
  // Puedes añadir aquí más campos nuevos cuando los tengas

  RutaViaje({
    required this.dia,
    required this.titulo,
    required this.descripcion,
  });

  factory RutaViaje.fromJson(Map<String, dynamic> json) {
    return RutaViaje(
      dia: json['dia'] ?? 0,
      titulo: json['titulo'] ?? '',
      descripcion: json['descripcion'] ?? '',
    );
  }
}

class Tour {
  final int id;
  final int destinoId;
  final String titulo;
  final double precio;
  final String duracion;
  final String imagenUrl;
  final String descripcionCorta;
  final String descripcionLarga;
  final bool destacado;
  final List<RutaViaje> rutaViaje; // <-- Aquí la lista

  Tour({
    required this.id,
    required this.destinoId,
    required this.titulo,
    required this.precio,
    required this.duracion,
    required this.imagenUrl,
    required this.descripcionCorta,
    required this.descripcionLarga,
    required this.destacado,
    required this.rutaViaje,
  });

  factory Tour.fromJson(Map<String, dynamic> json) {
    final String rutaImagen = json['imagen_destacada'] ?? '';
    final String imagenFinal = rutaImagen.replaceFirst('assets/images/', '');
    final String urlImagen =
        'https://cdev-dev.github.io/asia-travel-assets/images/destinos/$imagenFinal';

    final List<RutaViaje> listaRuta =
        (json['ruta_viaje'] as List<dynamic>?)
            ?.map((e) => RutaViaje.fromJson(e))
            .toList() ??
        [];

    return Tour(
      id: json['id'] ?? 0,
      destinoId: json['destino_id'] ?? 0,
      titulo: json['titulo'] ?? '',
      precio: (json['precio'] as num?)?.toDouble() ?? 0.0,
      duracion: json['duracion'] ?? '',
      imagenUrl: urlImagen,
      descripcionCorta: json['descripcion_corta'] ?? '',
      descripcionLarga: json['descripcion_larga'] ?? '',
      destacado: json['destacado'] ?? false,
      rutaViaje: listaRuta,
    );
  }
}
