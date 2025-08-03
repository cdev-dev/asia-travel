import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:asia_travel/ui/widgets/cards/styled_box.dart';
import 'package:asia_travel/ui/widgets/buttons/simple_button.dart';

class HtmlSection extends StatelessWidget {
  final String markdownData;
  final String buttonText;
  final VoidCallback onPressed;
  final bool useCard;
  final bool showButton; // <- nuevo parámetro

  const HtmlSection({
    super.key,
    required this.markdownData,
    required this.buttonText,
    required this.onPressed,
    this.useCard = true,
    this.showButton = true, // <- valor por defecto
  });

  @override
  Widget build(BuildContext context) {
    final String htmlData = md.markdownToHtml(markdownData);

    final content = Padding(
      padding: const EdgeInsets.all(0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Html(
            data: htmlData,
            style: {
              "body": Style(
                fontSize: FontSize(18),
                color: Colors.black87,
                textAlign: TextAlign.center,
              ),
              "h3": Style(
                fontSize: FontSize(26),
                fontWeight: FontWeight.bold,
                color: Colors.black,
                textAlign: TextAlign.center,
              ),
            },
          ),
          if (showButton) ...[
            const SizedBox(height: 12),
            SimpleButton(
              text: buttonText,
              backgroundColor: Colors.red,
              onPressed: onPressed,
            ),
          ],
        ],
      ),
    );

    if (useCard) {
      return StyledBox(child: content);
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
        child: content,
      );
    }
  }
}
