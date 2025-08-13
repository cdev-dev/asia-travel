import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterWidget extends StatelessWidget {
  const FooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Color gris para los iconos de redes sociales
    const socialIconBg = Color(0xFFE0E0E0);

    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Primera columna
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Asia Travel + dirección
                const Text(
                  'Asia Travel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text('Calle falsa 123'),
                const Text('Madrid 10203, España'),
                const SizedBox(height: 12),
                // Iconos de redes sociales
                Row(
                  children: [
                    _socialIcon(FontAwesomeIcons.facebook, socialIconBg, () {
                      // Acción futura para enlace
                    }),
                    const SizedBox(width: 8),
                    _socialIcon(
                      FontAwesomeIcons.instagram,
                      socialIconBg,
                      () {},
                    ),
                    const SizedBox(width: 8),
                    _socialIcon(FontAwesomeIcons.twitter, socialIconBg, () {}),
                  ],
                ),
                const SizedBox(height: 24),
                // Sobre Asia Travel
                const Text(
                  'Sobre Asia Travel',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                _footerLink('Quiénes somos', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Visita nuestra oficina', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Contacta con nosotros', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Preguntas frecuentes', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Guía de viajes', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Nuestro blog', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
              ],
            ),
          ),

          const SizedBox(width: 32),

          // Segunda columna
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Condiciones generales
                const Text(
                  'Condiciones generales',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                _footerLink('Condiciones generales', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Aviso legal', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Protección de datos', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Política de cookies', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Pago seguro', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                _footerLink('Seguros de viaje', () {
                  _launchURL(
                    'https://cdev-dev.github.io/asia-travel-assets/html/redireccion_muestra_asia_travel.html',
                  );
                }),
                const SizedBox(height: 24),
                // Horario de atención
                const Text(
                  'Horario de atención',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                const SizedBox(height: 4),
                const Text(
                  '10:00 a 14:00 y de 15:00 a 19:00 de Lunes a Viernes',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget para cada enlace
  Widget _footerLink(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.black,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }

  // Widget para los iconos de redes sociales
  Widget _socialIcon(IconData icon, Color bgColor, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
        child: Icon(icon, size: 20),
      ),
    );
  }

  void _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'No se pudo abrir $urlString';
    }
  }
}
