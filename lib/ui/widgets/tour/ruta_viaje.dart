import 'package:flutter/material.dart';
import 'package:asia_travel/data/models/tour_model.dart';

class RutaViajeWidget extends StatefulWidget {
  final List<RutaViaje> rutaViaje;

  const RutaViajeWidget({Key? key, required this.rutaViaje}) : super(key: key);

  @override
  State<RutaViajeWidget> createState() => _RutaViajeWidgetState();
}

class _RutaViajeWidgetState extends State<RutaViajeWidget> {
  final Set<int> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.rutaViaje.length * 2 - 1, (index) {
        if (index.isEven) {
          final int itemIndex = index ~/ 2;
          final dia = widget.rutaViaje[itemIndex];
          final bool isExpanded = _expandedItems.contains(itemIndex);

          return Column(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    if (isExpanded) {
                      _expandedItems.remove(itemIndex);
                    } else {
                      _expandedItems.add(itemIndex);
                    }
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Día ${dia.dia}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dia.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (isExpanded)
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 8.0,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withValues(alpha: 0.15),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(12),
                    child: Text(
                      dia.descripcion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          );
        } else {
          return const Icon(Icons.arrow_downward, size: 24, color: Colors.grey);
        }
      }),
    );
  }
}
