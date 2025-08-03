import 'package:flutter/material.dart';

class TripCardVertical extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String descripcionCorta;
  final String duration;
  final String price;
  final String descripcionCortaLabel;
  final String durationLabel;
  final String priceLabel;
  final double spacing;
  final VoidCallback? onTap;

  const TripCardVertical({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.descripcionCorta,
    required this.duration,
    required this.price,
    this.descripcionCortaLabel = '',
    this.durationLabel = 'Duración:',
    this.priceLabel = 'Desde:',
    this.spacing = 40, // Menor valor por defecto para diseño horizontal
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Imagen arriba
              Container(
                width: double.infinity, // Ocupa todo el ancho disponible
                height: 240,
                color: Colors.grey[300],
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 120,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(
                      child: Icon(Icons.broken_image, size: 40),
                    );
                  },
                ),
              ),

              // Texto debajo
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height:
                          56, // Altura fija para 2 líneas aproximadamente, ajusta según fuente y diseño
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(height: 8),

                    const SizedBox(height: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildInfoRow(
                          descripcionCortaLabel,
                          descripcionCorta,
                          boldValue: true,
                        ),
                        _buildInfoRow(durationLabel, duration),
                        _buildInfoRow(priceLabel, price),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _buildInfoRow(String label, String value, {bool boldValue = false}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: boldValue ? FontWeight.bold : FontWeight.normal,
            ),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}
