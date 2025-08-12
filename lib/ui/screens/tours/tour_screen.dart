// #region Imports
import 'package:asia_travel/ui/screens/tours/tour_viewmodel.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as developer;

import 'package:asia_travel/data/models/contenido_inicio_model.dart';
import 'package:asia_travel/data/models/tour_model.dart';

import 'package:asia_travel/ui/widgets/destino/destino_descripcion.dart';
import 'package:asia_travel/ui/widgets/tour/ruta_viaje.dart';
import 'package:asia_travel/ui/widgets/tour/tour_map_widget.dart';
import 'package:asia_travel/ui/widgets/tour/datos_clave_tour.dart';
import 'package:asia_travel/ui/widgets/tour/floating_action_buttons_widget.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
// #endregion

class TourScreen extends StatefulWidget {
  const TourScreen({super.key});

  @override
  State<TourScreen> createState() => _TourScreenState();
}

class _TourScreenState extends State<TourScreen>
    with SingleTickerProviderStateMixin {
  final TourViewModel _viewModel = TourViewModel();

  Tour? tour;
  int? tourId;
  List<Tour> tours = [];
  bool isLoadingDestino = true;
  bool isLoadingTours = true;

  ContenidoInicio? contenidoInicio;

  int? destinoId;

  // Controlador del mapa para flutter_map
  final MapController _mapController = MapController();

  // Índice del destino seleccionado en la ruta
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _loadContenidoInicio();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (tourId == null) {
      tourId = ModalRoute.of(context)!.settings.arguments as int;
      _loadTourById();
    }
  }

  Future<void> _loadTourById() async {
    setState(() => isLoadingDestino = true);
    try {
      final tourData = await _viewModel.cargarTourPorId(tourId!);
      if (!mounted) return;
      setState(() {
        tour = tourData;
        isLoadingDestino = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoadingDestino = false);
      debugPrint('Error cargando tour: $e');
    }
  }

  Future<void> _loadContenidoInicio() async {
    try {
      final contenido = await _viewModel.cargarContenidoInicio();
      if (!mounted) return;
      setState(() {
        contenidoInicio = contenido;
      });
    } catch (e) {
      developer.log('Error al cargar contenido inicio: $e');
    }
  }

  // Callback para manejar selección del día en la ruta
  void _onDiaSelected(int index) {
    setState(() {
      _selectedIndex = index;
      final dia = tour!.rutaViaje[index];
      // Mueve el mapa al destino seleccionado con zoom 13
      _mapController.move(LatLng(dia.latitud, dia.longitud), 13);
    });
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(230),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withAlpha(38),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          tour!.titulo,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(tour!.imagenUrl, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildDescripcion() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Datos clave del tour
            DatosClaveTour(precio: tour!.precio, dias: tour!.duracion),

            //Contrucción de la descripción del destino
            const SizedBox(height: 12),
            DestinoDescripcion(
              descripcionLarga: tour!.descripcionLarga,
              usarHtml: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRutaViaje() {
    if (tour == null || tour!.rutaViaje.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: RutaViajeWidget(
          rutaViaje: tour!.rutaViaje,
          onDiaSelected: _onDiaSelected,
          selectedIndex: _selectedIndex,
        ),
      ),
    );
  }

  Widget _buildMapa() {
    if (tour == null || tour!.rutaViaje.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }
    return SliverToBoxAdapter(
      child: TourMapWidget(
        puntos: tour!.rutaViaje,
        selectedIndex: _selectedIndex,
        mapController: _mapController,
        onMarkerTap: (index) {
          setState(() {
            _selectedIndex = index;
            _mapController.move(
              LatLng(
                tour!.rutaViaje[index].latitud,
                tour!.rutaViaje[index].longitud,
              ),
              13,
            );
          });
        },
      ),
    );
  }

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
    } else if (tour == null) {
      return Scaffold(body: Center(child: Text('Error al cargar destino')));
    }

    return Scaffold(
      extendBodyBehindAppBar: true, // si quieres que esté detrás del appbar
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              _buildSliverAppBar(),
              _buildDescripcion(),
              _buildRutaViaje(),
              _buildMapa(),
              _buildServicios(),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).padding.top + 56 / 2 - 17,
            right: 16,
            child: FloatingActionButtonsWidget(
              onSharePressed: () {
                // Aquí pon la acción que quieras para compartir
              },
              onFavoritePressed: () {
                // Aquí la acción para favorito
              },
            ),
          ),
        ],
      ),
    );
  }
}
