import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/services/tour_service_general.dart';

class TourViewModel {
  final TourService _tourService = TourService();

  // Carga todos los tours de todos los destinos
  Future<List<Tour>> cargarTodosLosTours() async {
    try {
      final tours = await _tourService.fetchAllTours();
      return tours;
    } catch (e) {
      rethrow;
    }
  }

  // Carga tours filtrados por destinoId
  Future<List<Tour>> cargarToursPorDestino(int destinoId) async {
    try {
      final tours = await _tourService.fetchAllTours();
      return tours;
    } catch (e) {
      rethrow;
    }
  }
}
