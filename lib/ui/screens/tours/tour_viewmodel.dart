import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/models/contenido_inicio_model.dart';

import 'package:asia_travel/data/services/tour_service_by_id.dart';
import 'package:asia_travel/data/services/tour_service_general.dart';
import 'package:asia_travel/data/services/contenido_inicio_service.dart';

class TourViewModel {
  final TourService _tourService = TourService(); // para fetchAllTours()
  final TourServiceById _tourServiceById =
      TourServiceById(); // para fetchToursByDestinoId y fetchTourById
  final ContenidoInicioService _contenidoService = ContenidoInicioService();

  Future<List<Tour>> cargarTodosLosTours() async {
    try {
      final tours = await _tourService.fetchAllTours();
      return tours;
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Tour>> cargarToursPorDestino(int destinoId) async {
    try {
      final tours = await _tourServiceById.fetchToursByDestinoId(destinoId);
      return tours;
    } catch (e) {
      rethrow;
    }
  }

  Future<Tour> cargarTourPorId(int id) async {
    try {
      final tour = await _tourServiceById.fetchTourById(id);
      return tour;
    } catch (e) {
      rethrow;
    }
  }

  Future<ContenidoInicio> cargarContenidoInicio() async {
    return await _contenidoService.fetchContenidoInicio();
  }
}
