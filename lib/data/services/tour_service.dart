import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/tour_model.dart';

class TourService {
  Future<List<Tour>> fetchDestinos() async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/tours.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((jsonItem) => Tour.fromJson(jsonItem)).toList();
    } else {
      throw Exception('Error al cargar los destinos');
    }
  }
}
