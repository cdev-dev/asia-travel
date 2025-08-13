import 'package:flutter/material.dart';

class ContactoDudasWidget extends StatelessWidget {
  const ContactoDudasWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red.shade200, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ==== Parte superior con fondo rojo claro ====
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: const Center(
              child: Text(
                "¿Tienes dudas?",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // ==== Parte inferior transparente ====
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Teléfono con icono
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Icons.phone, color: Colors.red, size: 28),
                    SizedBox(width: 8),
                    Text(
                      "123 12 12 12",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Horarios
                const Text(
                  "De lunes a Viernes",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 4),
                const Text(
                  "de 10:00 a 14:00",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
                const SizedBox(height: 4),
                const Text(
                  "de 15:00 a 19:00",
                  style: TextStyle(fontSize: 16, color: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
