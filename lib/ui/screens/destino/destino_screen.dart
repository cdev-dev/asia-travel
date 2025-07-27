import 'package:flutter/material.dart';

import 'package:asia_travel/ui/widgets/destino/destino_descripcion.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card.dart';

import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/services/destino_service.dart';
import 'package:asia_travel/data/services/tour_service.dart';
import 'package:asia_travel/data/models/tour_model.dart';

List<Tour> tours = [];
bool isToursLoading = true;

class DestinoScreen extends StatefulWidget {
  const DestinoScreen({super.key});

  @override
  State<DestinoScreen> createState() => _DestinoScreenState();
}

class _DestinoScreenState extends State<DestinoScreen> {
  Destino? destino;
  bool isLoading = true;
  int? destinoId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    destinoId ??= ModalRoute.of(context)!.settings.arguments as int;

    _loadDestino().then((_) {
      _loadTours(); // Cargar los tours solo después de haber cargado el destino
    });
  }

  Future<void> _loadDestino() async {
    final destinos = await DestinoService().fetchDestinos();
    final destinoEncontrado = destinos.firstWhere(
      (d) => d.id == destinoId,
      orElse: () => throw Exception('Destino no encontrado'),
    );
    setState(() {
      destino = destinoEncontrado;
      isLoading = false;
    });
  }

  Future<void> _loadTours() async {
    try {
      final toursData = await TourService().fetchToursByDestinoId(destinoId!);
      debugPrint('Tours cargados: ${toursData.length}');
      setState(() {
        tours = toursData;
        isToursLoading = false;
      });
    } catch (e) {
      setState(() {
        isToursLoading = false;
      });
      debugPrint('Error cargando tours: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  pinned: true,
                  title: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Text(
                      destino!.nombre,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      destino!.imagenUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: DestinoDescripcion(
                      descripcionLarga: destino!.descripcionLarga,
                    ),
                  ),
                ),

                // Texto: Nuestros viajes a {nombre}
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      child: Text(
                        'Nuestros viajes a ${destino!.nombre}',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

                // Lista de tours
                isToursLoading
                    ? const SliverToBoxAdapter(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final tour = tours[index];
                          return TripCard(
                            title: tour.titulo,
                            imageUrl: tour.imagenUrl,
                            duration: tour.duracion,
                            price: '${tour.precio.toStringAsFixed(0)}€',
                            onTap: () {
                              // Aquí podrías navegar a una pantalla de detalle del tour
                            },
                          );
                        }, childCount: tours.length),
                      ),
              ],
            ),
    );
  }
}
