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

import 'package:asia_travel/ui/routes/app_routes.dart';
import 'package:asia_travel/ui/screens/home/home_viewmodel.dart';
// #endregion

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeViewModel _viewModel = HomeViewModel(); // ViewModel para la lógica
  List<Destino> destinos = []; // Lista de destinos
  List<Tour> tours = [];

  ContenidoInicio? contenidoInicio; // Contenido de inicio

  @override
  void initState() {
    super.initState();
    _loadDestinos();
    _loadContenidoInicio();
    _loadTours();
  }

  // Carga destinos desde el ViewModel y actualiza el estado si el widget sigue montado
  Future<void> _loadDestinos() async {
    try {
      final data = await _viewModel.cargarDestinos();
      if (!mounted) return;
      setState(() {
        destinos = data;
      });
    } catch (e) {
      developer.log('Error al cargar destinos: $e');
    }
  }

  Future<void> _loadTours() async {
    try {
      final toursData = await _viewModel.cargarTodosLosTours();
      if (!mounted) return;
      setState(() {
        tours = toursData; // solo actualizas tours
      });
    } catch (e) {
      if (!mounted) return;
      debugPrint('Error cargando tours: $e');
    }
  }

  /// Carga contenido de inicio desde el ViewModel y actualiza el estado
  Future<void> _loadContenidoInicio() async {
    try {
      final contenido = await _viewModel.cargarContenidoInicio();
      if (!mounted) return;
      setState(() {
        contenidoInicio = contenido;
      });
    } catch (e) {
      // ignore: avoid_print
      developer.log('Error al cargar contenido inicio: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final destacados = tours.where((t) => t.destacado).toList();

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header personalizado
            const CustomHeader(),

            // Banner fijo
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
                ? const Padding(
                    padding: EdgeInsets.symmetric(vertical: 100),
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto con el tituloInicio si ya está cargado
                      if (contenidoInicio != null)
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

                      // Animación Lottie centrada
                      Center(
                        child: Lottie.asset(
                          'assets/animations/chinese_woman.json',
                          height: 300,
                          repeat: true,
                        ),
                      ),

                      // Texto subtitulo CULTURA EMBRIAGADORA
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6.0,
                          vertical: 1,
                        ),
                        child: ExpandableRoundBox(
                          text: contenidoInicio!.subtituloInicio,
                        ),
                      ),

                      // Texto nuestros destinos
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Text(
                          'Nuestros destinos',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Tarjeta destinos
                      SizedBox(
                        height: 240,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: destinos.length,
                          shrinkWrap: true,
                          physics: const ClampingScrollPhysics(),
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
                                spacing: 80, // espacio entre textos modificado
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    AppRoutes.destino,
                                    arguments: destino.id,
                                  );
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      // Sección HTML
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (contenidoInicio != null) ...[
                            // Seccopm ver todos los destinos
                            HtmlSection(
                              useCard: false,
                              markdownData: contenidoInicio!.especialistasAsia,
                              buttonText: 'Ver todos los destinos',
                              onPressed: () {
                                developer.log(
                                  'Botón ver todos los destinos pulsado',
                                );
                              },
                            ),

                            // Texto encima del carrusel
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16.0,
                                vertical: 8.0,
                              ),
                              child: Text(
                                'Nuestros viajes destacados',
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),

                            // Carrusel de tours destacados
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
                                      right: index == destacados.length - 1
                                          ? 16
                                          : 0,
                                    ),
                                    child: TripCardVertical(
                                      imageUrl: tour.imagenUrl,
                                      title: tour.titulo,
                                      descripcionCorta: tour.descripcionCorta,
                                      duration: tour.duracion,
                                      price:
                                          '${tour.precio.toStringAsFixed(0)} €',
                                      durationLabel: ' Duración:',
                                      priceLabel: ' Precio:',
                                      spacing: 0,
                                      onTap: () {
                                        // Acción al pulsar
                                      },
                                    ),
                                  );
                                },
                              ),
                            ),

                            // Sección viajes combinados
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

                            // Sección experiencias asiáticas
                            HtmlSection(
                              useCard: false,
                              markdownData:
                                  contenidoInicio!.experienciasAsiaticas,
                              showButton: false,
                              buttonText: '',
                              onPressed: () {},
                            ),
                          ],
                        ],
                      ),

                      // Sección de servicios
                      if (contenidoInicio != null) ...[
                        const SizedBox(height: 20),

                        // Fondo común para todos los servicios, incluyendo el título
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
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 8.0,
                                ),
                                child: Text(
                                  'Servicios',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...contenidoInicio!.servicios.map((servicio) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.network(
                                        servicio.imagen,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                              return const Icon(
                                                Icons.broken_image,
                                                size: 30,
                                              );
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
          ],
        ),
      ),
    );
  }
}
