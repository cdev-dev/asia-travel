import 'package:flutter/material.dart';

import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card.dart';
import 'package:asia_travel/ui/widgets/header/custom_header.dart';
import 'package:asia_travel/ui/routes/app_routes.dart';
import 'package:asia_travel/ui/screens/home/home_viewmodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();
  List<Destino> destinos = [];

  @override
  void initState() {
    super.initState();
    _loadDestinos();
  }

  Future<void> _loadDestinos() async {
    try {
      final data = await _viewModel.cargarDestinos();
      setState(() {
        destinos = data;
      });
    } catch (e) {
      print('Error al cargar destinos: $e');
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
          const SizedBox(height: 6),
          destinos.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
                  height: 240,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: destinos.length,
                    itemBuilder: (context, index) {
                      final destino = destinos[index];
                      return SizedBox(
                        width: 350,
                        child: TripCard(
                          title: destino.nombre,
                          imageUrl: destino.imagenUrl,
                          duration: '${destino.dias} días',
                          price: '${destino.precio.toStringAsFixed(2)} €',
                          onTap: () {
                            Navigator.of(context).pushNamed(
                              AppRoutes.destino,
                              arguments: destino.id, // 👈 Pasamos el ID
                            );
                          },
                        ),
                      );
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
