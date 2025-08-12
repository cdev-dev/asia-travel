import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_html/flutter_html.dart';

class DestinoDescripcion extends StatelessWidget {
  final String descripcionLarga;
  final bool usarHtml;

  const DestinoDescripcion({
    super.key,
    required this.descripcionLarga,
    this.usarHtml = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25), // alpha: 0.1 = 25 aprox
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: usarHtml
          ? Html(
              data: descripcionLarga,
              style: {
                "p": Style(
                  fontSize: FontSize(16),
                  color: Colors.black87,
                  textAlign: TextAlign.justify,
                ),
                "h1": Style(
                  fontSize: FontSize(24),
                  fontWeight: FontWeight.bold,
                ),
                "h2": Style(
                  fontSize: FontSize(20),
                  fontWeight: FontWeight.bold,
                ),
                // otros estilos...
              },
            )
          : MarkdownBody(
              data: descripcionLarga,
              styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context))
                  .copyWith(
                    p: const TextStyle(fontSize: 16, color: Colors.black87),
                    h1: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    h2: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    em: const TextStyle(fontStyle: FontStyle.italic),
                    strong: const TextStyle(fontWeight: FontWeight.bold),
                  ),
            ),
    );
  }
}
