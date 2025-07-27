import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/services/destino_service.dart';

class HomeViewModel {
  final DestinoService _service = DestinoService();

  Future<List<Destino>> cargarDestinos() async {
    return await _service.fetchDestinos();
  }
}
