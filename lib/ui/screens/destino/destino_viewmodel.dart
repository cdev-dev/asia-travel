import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/models/contenido_inicio_model.dart'; // O el archivo donde esté definido ContenidoInicio

import 'package:asia_travel/data/services/tour_service_by_id.dart';
import 'package:asia_travel/data/services/contenido_inicio_service.dart';

class DestinoViewModel {
  final TourServiceById _service = TourServiceById();
  final ContenidoInicioService _contenidoService = ContenidoInicioService();

  Future<List<Tour>> cargarTours(int destinoId) async {
    return await _service.fetchToursByDestinoId(destinoId);
  }

  Future<ContenidoInicio> cargarContenidoInicio() async {
    return await _contenidoService.fetchContenidoInicio();
  }
}
