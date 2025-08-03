import 'package:flutter/material.dart';

class TripCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String duration;
  final String price;
  final String durationLabel;
  final String priceLabel;
  final double spacing; // <-- nuevo parámetro para controlar el espacio
  final VoidCallback? onTap;

  const TripCard({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.duration,
    required this.price,
    this.durationLabel = 'Duración:',
    this.priceLabel = 'Desde:',
    this.spacing = 80, // valor por defecto igual que antes
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                imageUrl,
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 150,
                    color: Colors.grey[300],
                    child: const Icon(Icons.broken_image, size: 40),
                  );
                },
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 6.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('$durationLabel $duration'),
                        SizedBox(width: spacing), // aquí usamos el parámetro
                        Text('$priceLabel $price'),
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
