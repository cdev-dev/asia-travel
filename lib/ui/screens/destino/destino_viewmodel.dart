import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/data/services/tour_service_by_id.dart';

class DestinoViewModel {
  final TourServiceById _service = TourServiceById();

  Future<List<Tour>> cargarTours(int destinoId) async {
    return await _service.fetchToursByDestinoId(destinoId);
  }
}
