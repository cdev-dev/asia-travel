import 'package:flutter/material.dart';
import 'package:asia_travel/data/models/contenido_servicio_model.dart';

class ServiciosWidget extends StatelessWidget {
  final List<Servicio> servicios;

  const ServiciosWidget({super.key, required this.servicios});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[300], // Fondo gris
      child: ListView.builder(
        itemCount: servicios.length,
        itemBuilder: (context, index) {
          final servicio = servicios[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  servicio.imagen,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 100);
                  },
                ),
                const SizedBox(height: 8),
                Text(
                  servicio.descripcion,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
