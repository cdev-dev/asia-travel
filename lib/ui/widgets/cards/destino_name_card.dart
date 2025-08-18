import 'package:flutter/material.dart';

class DestinoNameCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final double? width;
  final Color? color; // <-- color opcional

  const DestinoNameCard({
    super.key,
    required this.title,
    this.width,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12.0),
      child: SizedBox(
        width: width ?? double.infinity, // <-- ancho fijo o expandir
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            backgroundColor: color ?? Colors.blueAccent,
          ),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
