import '../../../data/models/tour_model.dart';
import '../../../data/services/tour_service.dart';

class DestinoViewModel {
  final TourService _service = TourService();

  Future<List<Tour>> cargarTours() async {
    return await _service.fetchDestinos();
  }
}
