import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TourMapWidget extends StatelessWidget {
  final List<dynamic> puntos;
  final int? selectedIndex;
  final MapController mapController;
  final double height;
  final Function(int index)? onMarkerTap;

  const TourMapWidget({
    super.key,
    required this.puntos,
    required this.mapController,
    this.selectedIndex,
    this.height = 250,
    this.onMarkerTap,
  });

  @override
  Widget build(BuildContext context) {
    final markers = puntos.asMap().entries.map((entry) {
      final idx = entry.key;
      final dia = entry.value;
      final isSelected = selectedIndex != null && selectedIndex == idx;

      return Marker(
        point: LatLng(dia.latitud, dia.longitud),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => onMarkerTap?.call(idx),
          child: Icon(
            Icons.location_on,
            color: isSelected ? Colors.red : Colors.blue,
            size: isSelected ? 40 : 30,
          ),
        ),
      );
    }).toList();

    final initialPoint = selectedIndex != null
        ? LatLng(
            puntos[selectedIndex!].latitud,
            puntos[selectedIndex!].longitud,
          )
        : LatLng(puntos[0].latitud, puntos[0].longitud);

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(51),
            blurRadius: 8,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      clipBehavior: Clip.hardEdge,
      child: FlutterMap(
        mapController: mapController,
        options: MapOptions(
          // En 8.x se usa 'initialCenter' y 'initialZoom'
          initialCenter: initialPoint,
          initialZoom: 5,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.asia_travel',
          ),
          MarkerLayer(markers: markers),
        ],
      ),
    );
  }
}
