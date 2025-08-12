import 'package:flutter/material.dart';
import 'package:asia_travel/data/models/tour_model.dart';

class RutaViajeWidget extends StatefulWidget {
  final List<RutaViaje> rutaViaje;
  final Function(int index) onDiaSelected;
  final int? selectedIndex;

  const RutaViajeWidget({
    super.key,
    required this.rutaViaje,
    required this.onDiaSelected,
    this.selectedIndex,
  });

  @override
  State<RutaViajeWidget> createState() => _RutaViajeWidgetState();
}

class _RutaViajeWidgetState extends State<RutaViajeWidget>
    with TickerProviderStateMixin {
  final Set<int> _expandedItems = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(widget.rutaViaje.length * 2 - 1, (index) {
        if (index.isEven) {
          final int itemIndex = index ~/ 2;
          final dia = widget.rutaViaje[itemIndex];
          final bool isExpanded = _expandedItems.contains(itemIndex);
          final bool isSelected = widget.selectedIndex == itemIndex;

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
                    widget.onDiaSelected(itemIndex);
                  });
                },
                child: Container(
                  color: isSelected
                      ? Colors.grey.withAlpha(0)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Día ${dia.dia}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        dia.titulo,
                        style: const TextStyle(
                          fontSize: 18,
                          color: Color.fromARGB(255, 51, 51, 51),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Animamos el expandible con AnimatedSize
              AnimatedSize(
                duration: const Duration(milliseconds: 500),
                curve: Curves.bounceOut,
                child: isExpanded
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withAlpha(38),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
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
                      )
                    : const SizedBox.shrink(),
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
