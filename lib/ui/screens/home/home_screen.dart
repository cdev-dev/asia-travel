// #region Imports
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/models/contenido_inicio_model.dart';
import 'package:asia_travel/data/models/tour_model.dart';

import 'package:asia_travel/ui/widgets/cards/trip_card.dart';
import 'package:asia_travel/ui/widgets/header/custom_header.dart';
import 'package:asia_travel/ui/widgets/cards/expandable_round_box.dart';
import 'package:asia_travel/ui/widgets/cards/html_section.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card_vertical.dart';
import 'package:asia_travel/ui/widgets/header/footer_widget.dart';

import 'package:asia_travel/ui/routes/app_routes.dart';
import 'package:asia_travel/ui/screens/home/home_viewmodel.dart';
// #endregion

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel();

  // Datos que cargamos
  List<Destino> destinos = [];
  List<Tour> tours = [];
  ContenidoInicio? contenidoInicio;

  // Control de estado de carga y error
  bool _isLoading = true;
  bool _errorLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
    SliverToBoxAdapter(child: FooterWidget());
  }

  // Método para cargar todos los datos simultáneamente
  Future<void> _loadAllData() async {
    try {
      final results = await Future.wait([
        _viewModel.cargarDestinos(),
        _viewModel.cargarTodosLosTours(),
        _viewModel.cargarContenidoInicio(),
      ]);
      if (!mounted) return;
      setState(() {
        destinos = results[0] as List<Destino>;
        tours = results[1] as List<Tour>;
        contenidoInicio = results[2] as ContenidoInicio;
        _isLoading = false;
        _errorLoading = false;
      });
    } catch (e) {
      developer.log('Error cargando datos: $e');
      if (!mounted) return;
      setState(() {
        _isLoading = false;
        _errorLoading = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Filtramos tours destacados para mostrar en sección aparte
    final destacados = tours.where((t) => t.destacado).toList();

    // Controlamos estados de carga y error para mostrar UI adecuada
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_errorLoading) {
      return Scaffold(
        body: Center(
          child: Text(
            'Error al cargar los datos',
            style: TextStyle(fontSize: 18, color: Colors.red[700]),
          ),
        ),
      );
    }

    // UI principal si la carga fue exitosa
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomHeader(),

            // Banner simple
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

            // Sección contenido inicio si existe y no hay error
            if (contenidoInicio != null) ...[
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(
                  contenidoInicio!.tituloInicio,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Center(
                child: Lottie.asset(
                  'assets/animations/chinese_woman.json',
                  height: 300,
                  repeat: true,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 6.0,
                  vertical: 1,
                ),
                child: ExpandableRoundBox(
                  text: contenidoInicio!.subtituloInicio,
                ),
              ),
            ],

            // Título destinos
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                'Nuestros destinos',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),

            // Lista horizontal de destinos
            SizedBox(
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
                      price: '${destino.precio.toStringAsFixed(0)} €',
                      durationLabel: 'Duración:',
                      priceLabel: 'Desde:',
                      spacing: 80,
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.destino, arguments: destino.id);
                      },
                    ),
                  );
                },
              ),
            ),

            // Más secciones dependiendo de contenidoInicio y tours destacados
            if (contenidoInicio != null) ...[
              HtmlSection(
                useCard: false,
                markdownData: contenidoInicio!.especialistasAsia,
                buttonText: 'Ver todos los destinos',
                onPressed: () {
                  developer.log('Botón ver todos los destinos pulsado');
                },
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  'Nuestros viajes destacados',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(
                height: 450,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: destacados.length,
                  itemBuilder: (context, index) {
                    final tour = destacados[index];
                    return Container(
                      width: 240,
                      margin: EdgeInsets.only(
                        left: index == 0 ? 16 : 8,
                        right: index == destacados.length - 1 ? 16 : 0,
                      ),
                      child: TripCardVertical(
                        imageUrl: tour.imagenUrl,
                        title: tour.titulo,
                        descripcionCorta: tour.descripcionCorta,
                        duration: tour.duracion,
                        price: '${tour.precio.toStringAsFixed(0)} €',
                        durationLabel: ' Duración:',
                        priceLabel: ' Precio:',
                        onTap: () {
                          // Acción al pulsar destacado
                        },
                      ),
                    );
                  },
                ),
              ),

              HtmlSection(
                useCard: true,
                markdownData: contenidoInicio!.viajesCombinados,
                showButton: true,
                buttonText: 'Ver todos los viajes combinados',
                onPressed: () {
                  developer.log(
                    'Botón ver todos los viajes combinados pulsado',
                  );
                },
              ),

              HtmlSection(
                useCard: false,
                markdownData: contenidoInicio!.experienciasAsiaticas,
                showButton: false,
                buttonText: '',
                onPressed: () {},
              ),

              const SizedBox(height: 20),

              // Sección servicios
              Container(
                width: double.infinity,
                color: Colors.grey[200],
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 8,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                      child: Text(
                        'Servicios',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ...contenidoInicio!.servicios.map((servicio) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.network(
                              servicio.imagen,
                              height: 80,
                              width: 80,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.broken_image, size: 30);
                              },
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                servicio.descripcion,
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
