// #region Imports
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/ui/widgets/animations/slide_transition_card.dart';
import 'package:asia_travel/ui/widgets/destino/destino_descripcion.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card.dart';

import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/services/destino_service.dart';
import 'package:asia_travel/data/services/tour_service_by_id.dart';
import 'package:asia_travel/data/models/tour_model.dart';
// #endregion

class DestinoScreen extends StatefulWidget {
  const DestinoScreen({super.key});

  @override
  State<DestinoScreen> createState() => _DestinoScreenState();
}

class _DestinoScreenState extends State<DestinoScreen>
    with SingleTickerProviderStateMixin {
  Destino? destino;
  List<Tour> tours = [];
  bool isLoadingDestino = true;
  bool isLoadingTours = true;

  int? destinoId;

  // Control para animación del título
  bool _tituloVisible = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Configura el controlador y la animación para el título
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.8,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Obtiene el ID del destino de los argumentos de la ruta
    destinoId ??= ModalRoute.of(context)!.settings.arguments as int;

    // Carga destino y luego tours
    _loadDestino().then((_) => _loadTours());
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Carga los datos del destino desde el servicio
  Future<void> _loadDestino() async {
    try {
      final destinos = await DestinoService().fetchDestinos();
      final destinoEncontrado = destinos.firstWhere(
        (d) => d.id == destinoId,
        orElse: () => throw Exception('Destino no encontrado'),
      );
      setState(() {
        destino = destinoEncontrado;
        isLoadingDestino = false;
      });
    } catch (e) {
      // Manejo de error si quieres
      setState(() {
        isLoadingDestino = false;
      });
      debugPrint('Error cargando destino: $e');
    }
  }

  // Carga los tours asociados al destino
  Future<void> _loadTours() async {
    try {
      final toursData = await TourServiceById().fetchToursByDestinoId(
        destinoId!,
      );
      setState(() {
        tours = toursData;
        isLoadingTours = false;
      });
    } catch (e) {
      setState(() {
        isLoadingTours = false;
      });
      debugPrint('Error cargando tours: $e');
    }
  }

  // Construye el encabezado con imagen y título del destino
  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
        background: Image.network(destino!.imagenUrl, fit: BoxFit.cover),
      ),
    );
  }

  // Construye la descripción larga del destino
  Widget _buildDescripcion() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: DestinoDescripcion(descripcionLarga: destino!.descripcionLarga),
      ),
    );
  }

  // Construye el título animado "Nuestros viajes a {nombre}"
  Widget _buildAnimatedTitulo() {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key('titulo-viajes'),
        onVisibilityChanged: (info) {
          if (!mounted) {
            return; // Evita hacer nada si el widget ya no está montado
          }

          if (info.visibleFraction > 0.3 && !_tituloVisible) {
            setState(() {
              _tituloVisible = true;
            });
            _controller.forward(from: 0.0); // inicia la animación
          } else if (info.visibleFraction == 0 && _tituloVisible) {
            setState(() {
              _tituloVisible = false;
            });
            _controller.reset(); // resetea la animación para la próxima vez
          }
        },

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: ScaleTransition(
            scale: _scaleAnimation,
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
      ),
    );
  }

  // Construye la lista de tours, con animación de entrada para cada tarjeta
  Widget _buildToursList() {
    if (isLoadingTours) {
      return const SliverToBoxAdapter(
        child: Center(child: CircularProgressIndicator()),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate((context, index) {
        final tour = tours[index];
        return SlideTransitionCard(
          delay: Duration(milliseconds: index * 150), // retraso incremental
          duration: const Duration(milliseconds: 3000), //velocidad de animación
          child: TripCard(
            title: tour.titulo,
            imageUrl: tour.imagenUrl,
            duration: tour.duracion,
            price: '${tour.precio.toStringAsFixed(0)}€',
            durationLabel: 'Duración:',
            priceLabel: 'Precio:',
            spacing: 150, // espacio entre textos modificado
            onTap: () {
              developer.log('Navegando a detalle del tour: ${tour.titulo}');
            },
          ),
        );
      }, childCount: tours.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Mientras carga destino mostramos loader
    if (isLoadingDestino || destino == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildDescripcion(),
          _buildAnimatedTitulo(),
          _buildToursList(),
        ],
      ),
    );
  }
}
