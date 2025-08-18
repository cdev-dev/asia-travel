import 'package:flutter/material.dart';
import 'package:asia_travel/ui/widgets/buttons/simple_button.dart';

class ViajeAMedidaWidget extends StatelessWidget {
  const ViajeAMedidaWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Stack(
          children: [
            // Imagen descargada desde URL
            Image.network(
              'https://cdev-dev.github.io/asia-travel-assets/images/varios/viaje_a_medida.png',
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
            ),

            // Capa semi-transparente para mejorar legibilidad del texto
            Container(
              width: double.infinity,
              height: 220,
              color: Colors.black.withValues(alpha: 0.4),
            ),

            // Texto y botón centrados
            Positioned.fill(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'También lo personalizamos a tu gusto.\n¡Crea tu viaje y pídenos presupuesto!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: 180,
                      child: SimpleButton(
                        text: 'Viajes a medida',
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        onPressed: () {
                          // print("Botón viajes a medida pulsado");
                          // Aquí puedes añadir la acción que quieras
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
