import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class DestinoDescripcion extends StatelessWidget {
  final String descripcionLarga;

  const DestinoDescripcion({super.key, required this.descripcionLarga});

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
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: MarkdownBody(
        data: descripcionLarga,
        styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
          p: const TextStyle(fontSize: 16, color: Colors.black87),
          h1: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          h2: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          em: const TextStyle(fontStyle: FontStyle.italic),
          strong: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class DestinoImage extends StatelessWidget {
  final String imageUrl;

  const DestinoImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9, // 👈 Aquí defines la proporción deseada
      child: Image.network(
        imageUrl,
        fit: BoxFit.cover, // 👈 Rellena el espacio sin deformar
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(child: CircularProgressIndicator());
        },
        errorBuilder: (context, error, stackTrace) {
          return const Center(child: Icon(Icons.broken_image));
        },
      ),
    );
  }
}
