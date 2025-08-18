// #region Imports
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/data/models/contenido_inicio_model.dart';
import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/models/tour_model.dart';
import 'package:asia_travel/ui/routes/app_routes.dart';

import 'package:asia_travel/ui/screens/todos_los_destinos/todos_los_destinos_viewmodel.dart';

import 'package:asia_travel/ui/widgets/header/custom_header.dart';
import 'package:asia_travel/ui/widgets/header/footer_widget.dart';
import 'package:asia_travel/ui/widgets/cards/destino_name_card.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card_vertical.dart';

// #endregion

class TodosLosDestinosScreen extends StatefulWidget {
  const TodosLosDestinosScreen({super.key});

  @override
  State<TodosLosDestinosScreen> createState() => _TodosLosDestinosScreenState();
}

class _TodosLosDestinosScreenState extends State<TodosLosDestinosScreen> {
  final TodosLosDestinosViewmodel _viewModel = TodosLosDestinosViewmodel();

  // Datos cargados
  ContenidoInicio? contenidoInicio;
  List<Destino> destinos = [];
  List<Tour> tours = [];

  // Estado de carga y error
  bool _isLoading = true;
  bool _errorLoading = false;

  @override
  void initState() {
    super.initState();
    _loadAllData();
  }

  Future<void> _loadAllData() async {
    setState(() => _isLoading = true);
    try {
      final results = await Future.wait([
        _viewModel.cargarContenidoInicio(),
        _viewModel.cargarDestinos(),
        _viewModel.cargarTodosLosTours(),
      ]);

      if (!mounted) return;

      setState(() {
        contenidoInicio = results[0] as ContenidoInicio;
        destinos = results[1] as List<Destino>;
        tours = results[2] as List<Tour>;
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

  Widget _buildMainSection() {
    return Stack(
      children: [
        // Fondo único
        Positioned.fill(
          child: Image.network(
            'https://cdev-dev.github.io/asia-travel-assets/images/varios/todos_los_destinos.png',
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Container(
                color: Colors.grey[200],
                child: const Center(child: CircularProgressIndicator()),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                child: const Center(child: Icon(Icons.broken_image, size: 40)),
              );
            },
          ),
        ),
        // Contenido encima del fondo
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(), // Tu widget de título
              _buildDestinosButtonsGrid(), // Tu grid de botones
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Center(
        child: Text(
          'Encuentra tu viaje a Asia y Oceanía',
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildDestinosButtonsGrid() {
    const int filas = 3;
    List<List<Destino>> filasDestinos = List.generate(filas, (_) => []);

    for (int i = 0; i < destinos.length; i++) {
      filasDestinos[i % filas].add(destinos[i]);
    }

    //Colores botones
    final List<Color> colores = [
      Colors.red[600]!,
      Colors.red[500]!,
      Colors.red[400]!,
      Colors.red[300]!,
    ];

    int contadorBotones = 0; // contador global para aplicar colores

    return SizedBox(
      height: 3 * 70.0 + 56.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(filasDestinos[0].length, (index) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(filas, (filaIndex) {
                if (index < filasDestinos[filaIndex].length) {
                  final destino = filasDestinos[filaIndex][index];
                  final colorBoton = colores[contadorBotones % colores.length];
                  contadorBotones++;
                  return Padding(
                    padding: const EdgeInsets.all(1.0),
                    child: DestinoNameCard(
                      title: destino.nombre,
                      color: colorBoton,
                      width: 170,
                      onTap: () {
                        Navigator.of(
                          context,
                        ).pushNamed(AppRoutes.destino, arguments: destino.id);
                      },
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              }),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildTripsSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: GridView.builder(
        shrinkWrap: true, // Para que se ajuste al contenido
        physics:
            NeverScrollableScrollPhysics(), // Evita que haga scroll interno
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Dos columnas
          crossAxisSpacing: 16, // Espacio horizontal entre columnas
          mainAxisSpacing: 16, // Espacio vertical entre filas
          childAspectRatio:
              0.375, // Ajusta la proporción ancho/alto de las tarjetas
        ),
        itemCount: tours.length,
        itemBuilder: (context, index) {
          final tour = tours[index];
          return TripCardVertical(
            title: tour.titulo,
            imageUrl: tour.imagenUrl,
            descripcionCorta: tour.descripcionCorta,
            duration: tour.duracion,
            price: '${tour.precio.toStringAsFixed(0)} €',
            durationLabel: ' Duración:',
            priceLabel: ' Desde:',
            spacing: 16,
            onTap: () {
              Navigator.of(
                context,
              ).pushNamed(AppRoutes.tour, arguments: tour.id);
            },
          );
        },
      ),
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
            _buildMainSection(),
            const SizedBox(height: 6),
            _buildTripsSection(),
            _buildServicios(),
            const FooterWidget(),
          ],
        ),
      ),
    );
  }
}
