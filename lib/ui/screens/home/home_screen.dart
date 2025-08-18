// #region Imports
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/models/contenido_inicio_model.dart';
import 'package:asia_travel/data/models/tour_model.dart';

import 'package:asia_travel/ui/widgets/header/custom_header.dart';
import 'package:asia_travel/ui/widgets/header/footer_widget.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card_vertical.dart';
import 'package:asia_travel/ui/widgets/cards/expandable_round_box.dart';
import 'package:asia_travel/ui/widgets/cards/html_section.dart';

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

  // Datos cargados
  List<Destino> destinos = [];
  List<Tour> tours = [];
  ContenidoInicio? contenidoInicio;

  // Estado de carga y error
  bool _isLoading = true;
  bool _errorLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

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

  // --- Widgets de secciones ---
  Widget _buildHeader() {
    return const CustomHeader();
  }

  Widget _buildBanner() {
    return Container(
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
    );
  }

  Widget _buildContenidoInicio() {
    if (contenidoInicio == null) return const SizedBox();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
          child: Text(
            contenidoInicio!.tituloInicio,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
        Center(child: Image.asset('assets/icons/LogoNew.png', height: 300)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 1),
          child: ExpandableRoundBox(text: contenidoInicio!.subtituloInicio),
        ),
      ],
    );
  }

  //Build Lista de destinos
  Widget _buildDestinosList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Nuestros destinos',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
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
      ],
    );
  }

  // Build Especialistas en Asia y tours destacados
  Widget _buildToursDestacados() {
    final destacados = tours.where((t) => t.destacado).toList();
    if (contenidoInicio == null) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        HtmlSection(
          useCard: false,
          markdownData: contenidoInicio!.especialistasAsia,
          buttonText: 'Ver todos los destinos',
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.todosLosDestinos);
          },
        ),
        const SizedBox(height: 6),
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
                    Navigator.pushNamed(
                      context,
                      AppRoutes
                          .tour, // la ruta que tengas definida para TourScreen
                      arguments: tour.id, // aquí pasas el id del tour
                    );
                  },
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSeccionesHtml() {
    if (contenidoInicio == null) return const SizedBox();
    return Column(
      children: [
        HtmlSection(
          useCard: true,
          markdownData: contenidoInicio!.viajesCombinados,
          showButton: true,
          buttonText: 'Ver todos los viajes combinados',
          onPressed: () {
            developer.log('Botón ver todos los viajes combinados pulsado');
          },
        ),
        HtmlSection(
          useCard: false,
          markdownData: contenidoInicio!.experienciasAsiaticas,
          showButton: false,
          buttonText: '',
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildServicios() {
    if (contenidoInicio == null) return const SizedBox();
    return Container(
      width: double.infinity,
      color: Colors.grey[300],
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'Servicios',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          ...contenidoInicio!.servicios.map((servicio) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
    );
  }

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(),
            _buildBanner(),
            const SizedBox(height: 6),
            _buildContenidoInicio(),
            _buildDestinosList(),
            _buildToursDestacados(),
            _buildSeccionesHtml(),
            const SizedBox(height: 20),
            _buildServicios(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
