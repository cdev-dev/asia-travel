import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/services/tour_service.dart';

class DestinoViewModel {
  final TourService _service = TourService();

  Future<List<Tour>> cargarTours(int destinoId) async {
    return await _service.fetchToursByDestinoId(destinoId);
  }
}
