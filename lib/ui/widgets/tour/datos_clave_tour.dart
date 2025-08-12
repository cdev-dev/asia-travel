import 'package:flutter/material.dart';

class DatosClaveTour extends StatelessWidget {
  final double precio;
  final String dias;

  const DatosClaveTour({required this.precio, required this.dias, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _InfoItem(
                icon: Icons.euro,
                label: '${precio.toStringAsFixed(2)} €',
              ),
              _InfoItem(icon: Icons.schedule, label: dias),
            ],
          ),
          const SizedBox(height: 12),
          const Text(
            'Todos nuestros viajes se realizan con guía en español.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
          ),
        ],
      ),
    );
  }
}

class _InfoItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoItem({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 28, color: Colors.redAccent),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
