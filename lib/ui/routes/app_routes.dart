import 'package:flutter/material.dart';
import '../screens/home/home_screen.dart';
import '../screens/destino/destino_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String destino = '/destino';

  static Map<String, WidgetBuilder> get routes => {
    home: (context) => const HomeScreen(),
    destino: (context) => const DestinoScreen(),
  };
}
