// #region Imports
import 'package:asia_travel/ui/screens/destino/destino_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/data/models/contenido_inicio_model.dart';
import 'package:asia_travel/data/models/destino_model.dart';
import 'package:asia_travel/data/models/tour_model.dart';

import 'package:asia_travel/ui/widgets/animations/slide_transition_card.dart';
import 'package:asia_travel/ui/widgets/destino/destino_descripcion.dart';
import 'package:asia_travel/ui/widgets/cards/trip_card.dart';
import 'package:asia_travel/ui/widgets/destino/viajes_a_medida_widget.dart';
import 'package:asia_travel/ui/widgets/header/footer_widget.dart';

import 'package:asia_travel/data/services/destino_service.dart';
import 'package:asia_travel/data/services/tour_service_by_id.dart';

// #endregion

class DestinoScreen extends StatefulWidget {
  const DestinoScreen({super.key});

  @override
  State<DestinoScreen> createState() => _DestinoScreenState();
}

class _DestinoScreenState extends State<DestinoScreen>
    with SingleTickerProviderStateMixin {
  final DestinoViewModel _viewModel = DestinoViewModel();
  Destino? destino;
  List<Tour> tours = [];
  bool isLoadingDestino = true;
  bool isLoadingTours = true;

  ContenidoInicio? contenidoInicio; // Contenido de inicio

  int? destinoId;

  // Animación título
  bool _tituloVisible = false;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _loadContenidoInicio();
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
    if (destinoId == null) {
      destinoId = ModalRoute.of(context)!.settings.arguments as int;
      _loadDestino().then((_) => _loadTours());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _loadDestino() async {
    try {
      final destinos = await DestinoService().fetchDestinos();
      final destinoEncontrado = destinos.firstWhere(
        (d) => d.id == destinoId,
        orElse: () => throw Exception('Destino no encontrado'),
      );
      if (!mounted) return;
      setState(() {
        destino = destinoEncontrado;
        isLoadingDestino = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingDestino = false);
      debugPrint('Error cargando destino: $e');
    }
  }

  Future<void> _loadTours() async {
    try {
      final toursData = await TourServiceById().fetchToursByDestinoId(
        destinoId!,
      );
      if (!mounted) return;
      setState(() {
        tours = toursData;
        isLoadingTours = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingTours = false);
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
              color: Colors.white.withValues(alpha: 0.15),
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

  Widget _buildDescripcion() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: DestinoDescripcion(descripcionLarga: destino!.descripcionLarga),
      ),
    );
  }

  // Widget para mostrar el título animado y NUestros viajes a...
  Widget _buildAnimatedTitulo() {
    return SliverToBoxAdapter(
      child: VisibilityDetector(
        key: const Key('titulo-viajes'),
        onVisibilityChanged: (info) {
          if (!mounted) return;
          if (info.visibleFraction > 0.3 && !_tituloVisible) {
            setState(() => _tituloVisible = true);
            _controller.forward(from: 0.0);
          } else if (info.visibleFraction == 0 && _tituloVisible) {
            setState(() => _tituloVisible = false);
            _controller.reset();
            _controller.stop();
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

  // Widget para mostrar la lista de tours
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
          delay: Duration(milliseconds: index * 150),
          duration: const Duration(milliseconds: 3000),
          child: TripCard(
            title: tour.titulo,
            imageUrl: tour.imagenUrl,
            duration: tour.duracion,
            price: '${tour.precio.toStringAsFixed(0)}€',
            durationLabel: 'Duración:',
            priceLabel: 'Precio:',
            spacing: 150,
            onTap: () {
              developer.log(
                'Navegando a detalle del tour: ${tour.titulo} con id ${tour.id}',
              );
              Navigator.pushNamed(
                context,
                '/tour',
                arguments: tour.id, // Pasamos el id del tour
              );
            },
          ),
        );
      }, childCount: tours.length),
    );
  }

  // Construcción del widget Viajes a Medida
  SliverToBoxAdapter _buildViajeAMedida() {
    return SliverToBoxAdapter(child: ViajeAMedidaWidget());
  }

  //Widget para mostrar los servicios
  Widget _buildServicios() {
    return SliverToBoxAdapter(
      child: Container(
        width: double.infinity,
        color: Colors.grey[200],
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              child: Text(
                'Servicios',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            ...(contenidoInicio?.servicios ?? []).map((servicio) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
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
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoadingDestino) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    } else if (destino == null) {
      return Scaffold(body: Center(child: Text('Error al cargar destino')));
    }
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          _buildDescripcion(),
          _buildAnimatedTitulo(),
          _buildToursList(),
          _buildViajeAMedida(),
          _buildServicios(),

          SliverToBoxAdapter(child: FooterWidget()),
        ],
      ),
    );
  }
}
