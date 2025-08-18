import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/models/contenido_inicio_model.dart';

import 'package:asia_travel/data/services/destino_service.dart';
import 'package:asia_travel/data/services/contenido_inicio_service.dart';

import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/services/tour_service_general.dart';

class TodosLosDestinosViewmodel {
  final DestinoService _service = DestinoService();
  final ContenidoInicioService _contenidoService = ContenidoInicioService();
  final TourService _tourService = TourService();

  Future<List<Destino>> cargarDestinos() async {
    return await _service.fetchDestinos();
  }

  Future<ContenidoInicio> cargarContenidoInicio() async {
    return await _contenidoService.fetchContenidoInicio();
  }

  Future<List<Tour>> cargarTodosLosTours() async {
    try {
      return await _tourService.fetchAllTours();
    } catch (e) {
      rethrow;
    }
  }
}
