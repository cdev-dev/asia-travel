import '../../../data/models/destino_model.dart';
import '../../../data/services/destino_service.dart';

class HomeViewModel {
  final DestinoService _service = DestinoService();

  Future<List<Destino>> cargarDestinos() async {
    return await _service.fetchDestinos();
  }
}
