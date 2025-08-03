import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:asia_travel/data/models/tour_model.dart';

class TourService {
  Future<List<Tour>> fetchAllTours() async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/tours.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      // Recorremos todos los destinos y recogemos todos los tours en una lista
      List<Tour> allTours = [];

      for (var destino in jsonList) {
        if (destino['tours'] != null) {
          final List<dynamic> toursJson = destino['tours'];

          allTours.addAll(
            toursJson.map((json) {
              // Asegurar que cada tour tenga el destino_id
              if (json['destino_id'] == null) {
                json['destino_id'] = destino['destino_id'];
              }
              return Tour.fromJson(json);
            }).toList(),
          );
        }
      }

      return allTours;
    } else {
      throw Exception('Error al cargar los tours');
    }
  }
}
