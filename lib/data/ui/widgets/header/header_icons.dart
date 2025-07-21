import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HeaderIcons extends StatelessWidget {
  const HeaderIcons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.phone, color: Colors.white),
        SizedBox(width: 12),
        FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white),
        SizedBox(width: 12),
        Icon(Icons.public, color: Colors.white),
        SizedBox(width: 12),
        Icon(Icons.menu, color: Colors.white),
      ],
    );
  }
}
