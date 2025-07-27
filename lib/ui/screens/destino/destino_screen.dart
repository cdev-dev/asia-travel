import 'package:flutter/material.dart';
import 'destino_viewmodel.dart';
import '../../widgets/header/custom_header.dart';
import '../../widgets/cards/trip_card.dart';
import '../../../ui/routes/app_routes.dart';

class DestinoScreen extends StatefulWidget {
  const DestinoScreen({super.key});

  @override
  State<DestinoScreen> createState() => _DestinoScreenState();
}

class _DestinoScreenState extends State<DestinoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Column(children: [const CustomHeader()]));
  }
}
