import 'package:flutter/material.dart';
import 'logo_title.dart';
import 'header_icons.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      // <-- Esto asegura que el contenido no quede debajo de la barra de estado
      bottom: false, // Solo aplica para la parte superior
      child: Container(
        color: Colors.red,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [LogoTitle(), HeaderIcons()],
        ),
      ),
    );
  }
}
