import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/destino_model.dart';

class DestinoService {
  Future<List<Destino>> fetchDestinos() async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/destinos.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Destino.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Error al cargar los tours');
    }
  }
}
