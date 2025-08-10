import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:asia_travel/data/models/tour_model.dart';

class TourServiceById {
  Future<List<Tour>> fetchToursByDestinoId(int destinoId) async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/tours.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      // Filtra solo el destino que coincide
      final destino = jsonList.firstWhere(
        (d) => d['destino_id'] == destinoId,
        orElse: () => null,
      );

      if (destino == null || destino['tours'] == null) {
        return []; // No hay tours para este destino
      }

      final List<dynamic> toursJson = destino['tours'];
      return toursJson.map((json) => Tour.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los tours');
    }
  }

  Future<Tour> fetchTourById(int id) async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/tours.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      for (var destino in jsonList) {
        if (destino['tours'] != null) {
          final toursJson = destino['tours'] as List<dynamic>;

          final tourJson = toursJson.firstWhere(
            (tour) => tour['id'] == id,
            orElse: () => null,
          );

          if (tourJson != null) {
            return Tour.fromJson(tourJson);
          }
        }
      }
      throw Exception('Tour con id $id no encontrado');
    } else {
      throw Exception('Error al cargar los tours');
    }
  }
}
