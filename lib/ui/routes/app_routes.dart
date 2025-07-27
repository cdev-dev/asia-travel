import 'package:flutter/material.dart';

import 'package:asia_travel/ui/screens/home/home_screen.dart';
import 'package:asia_travel/ui/screens/destino/destino_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String destino = '/destino';

  // app_routes.dart
  static Map<String, WidgetBuilder> get routes => {
    '/': (context) => const HomeScreen(),
    '/home': (context) => const HomeScreen(),
    '/destino': (context) => const DestinoScreen(),
  };
}
