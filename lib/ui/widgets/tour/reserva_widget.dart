import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:asia_travel/ui/widgets/buttons/simple_button.dart';

class ReservaWidget extends StatelessWidget {
  final double precio;
  final String duracionTexto;

  const ReservaWidget({
    super.key,
    required this.precio,
    required this.duracionTexto,
  });

  int _parseDias(String? s) {
    if (s == null) return 0;
    final m = RegExp(r'\d+').firstMatch(s);
    return m != null ? int.parse(m.group(0)!) : 0;
  }

  @override
  Widget build(BuildContext context) {
    final duracionDias = _parseDias(duracionTexto);
    final tasas = precio * 0.15;
    final total = precio + tasas;

    final fechaInicio = DateTime(2025, 11, 10);
    final fechaFin = fechaInicio.add(Duration(days: duracionDias));
    final formatoFecha = DateFormat("dd/MM");

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
              color: Colors.red.shade50,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Línea 1: Desde + precio
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      "Desde ",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "${precio.toStringAsFixed(2)}€",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),

                // Línea 2: + tasas + precio total
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "+ tasas: ${tasas.toStringAsFixed(2)}€",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      "(${total.toStringAsFixed(2)}€)",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ==== Parte inferior transparente ====
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Row(
                  children: [
                    Icon(Icons.language, color: Colors.red),
                    SizedBox(width: 6),
                    Text("En castellano", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 4),

                const Row(
                  children: [
                    Icon(Icons.people, color: Colors.red),
                    SizedBox(width: 6),
                    Text("En grupo", style: TextStyle(fontSize: 16)),
                  ],
                ),
                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(Icons.calendar_today, color: Colors.red),
                    const SizedBox(width: 6),
                    Text(
                      "Lunes ${formatoFecha.format(fechaInicio)} al ${formatoFecha.format(fechaFin)} del 2025",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),

                const SizedBox(height: 12),

                // ==== Botón 1: Pide presupuesto ====
                SizedBox(
                  width: double.infinity,
                  child: SimpleButton(
                    text: "Pide presupuesto",
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      print("Presupuesto solicitado");
                    },
                  ),
                ),

                const SizedBox(height: 8),

                // ==== Botón 2: Descargar itinerario ====
                SizedBox(
                  width: double.infinity,
                  child: SimpleButton(
                    text: "Descargar el itinerario en PDF",
                    backgroundColor: Colors.red.shade200,
                    foregroundColor: Colors.white,
                    onPressed: () {
                      print("Descargando itinerario en PDF");
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
