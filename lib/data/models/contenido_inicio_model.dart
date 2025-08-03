import 'package:asia_travel/data/models/contenido_servicio_model.dart'; // <-- Añade esta línea

class ContenidoInicio {
  final String tituloInicio;
  final String subtituloInicio;
  final String especialistasAsia;
  final String viajesCombinados;
  final String experienciasAsiaticas;
  final List<Servicio> servicios;

  ContenidoInicio({
    required this.tituloInicio,
    required this.subtituloInicio,
    required this.especialistasAsia,
    required this.viajesCombinados,
    required this.experienciasAsiaticas,
    required this.servicios,
  });

  factory ContenidoInicio.fromJson(Map<String, dynamic> json) {
    return ContenidoInicio(
      tituloInicio: (json['titulo_inicio'] as List).first,
      subtituloInicio: (json['subtitulo_inicio'] as List).first,
      especialistasAsia: (json['especialistas_asia'] as List).first,
      viajesCombinados: (json['viajes_combinados'] as List).first,
      experienciasAsiaticas: (json['experiencias_asiaticas'] as List).first,
      servicios: (json['servicios'] as List)
          .map((e) => Servicio.fromJson(e))
          .toList(),
    );
  }
}
