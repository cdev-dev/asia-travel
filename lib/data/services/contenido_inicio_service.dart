import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:asia_travel/data/models/contenido_inicio_model.dart';

class ContenidoInicioService {
  Future<ContenidoInicio> fetchContenidoInicio() async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/contenido_inicio.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonMap = json.decode(response.body);
      return ContenidoInicio.fromJson(jsonMap);
    } else {
      throw Exception('Error al cargar el contenido de inicio');
    }
  }
}
