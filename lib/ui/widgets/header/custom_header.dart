import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:asia_travel/ui/widgets/header/logo_title.dart';
import 'package:asia_travel/ui/widgets/header/header_icons.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent, // o el color que prefieras
      ),
      child: Container(
        color: Colors.red,
        padding: EdgeInsets.fromLTRB(
          16,
          6 + MediaQuery.of(context).padding.top, // suma padding top dinámico
          16,
          24,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [LogoTitle(), HeaderIcons()],
        ),
      ),
    );
  }
}
