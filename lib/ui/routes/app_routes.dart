import 'package:flutter/material.dart';

import 'package:asia_travel/ui/screens/home/home_screen.dart';
import 'package:asia_travel/ui/screens/destino/destino_screen.dart';
import 'package:asia_travel/ui/screens/tours/tour_screen.dart';
import 'package:asia_travel/ui/screens/todos_los_destinos/todos_los_destinos_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String destino = '/destino';
  static const String tour = '/tour';
  static const String todosLosDestinos = '/todosLosDestinos';

  // app_routes.dart
  static Map<String, WidgetBuilder> get routes => {
    '/': (context) => const HomeScreen(),
    '/home': (context) => const HomeScreen(),
    '/destino': (context) => const DestinoScreen(),
    '/tour': (context) => const TourScreen(),
    '/todosLosDestinos': (context) => const TodosLosDestinosScreen(),
  };
}
