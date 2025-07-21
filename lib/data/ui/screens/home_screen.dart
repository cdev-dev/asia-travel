import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../widgets/cards/trip_card.dart';
import '../widgets/header/custom_header.dart';
import 'package:asia_travel/data/models/destino_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Destino> destinos = [];

  @override
  void initState() {
    super.initState();
    cargarDestino();
  }

  Future<void> cargarDestino() async {
    final url = Uri.parse(
      'https://cdev-dev.github.io/asia-travel-assets/data/destinos.json',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);

      setState(() {
        destinos = jsonList
            .map((jsonItem) => Destino.fromJson(jsonItem))
            .toList();
      });
    } else {
      print('Error al cargar los datos');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomHeader(),
          Container(
            width: double.infinity,
            color: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: const Center(
              child: Text(
                '¿Te llamamos?',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            child: destinos.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal, // horizontal
                    itemCount: destinos.length,
                    itemBuilder: (context, index) {
                      final destino = destinos[index];
                      return TripCard(
                        title: destino.nombre,
                        imageUrl: destino.imagenUrl,
                        duration: '10 días',
                        price: '1.499€',
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
