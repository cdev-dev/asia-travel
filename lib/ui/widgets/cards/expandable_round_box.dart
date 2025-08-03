import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:asia_travel/ui/widgets/cards/styled_box.dart';

class ExpandableRoundBox extends StatefulWidget {
  final String text;

  const ExpandableRoundBox({super.key, required this.text});

  @override
  State<ExpandableRoundBox> createState() => _ExpandableRoundBoxState();
}

class _ExpandableRoundBoxState extends State<ExpandableRoundBox>
    with SingleTickerProviderStateMixin {
  bool _expanded = false;

  void _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    final visibleText = _expanded
        ? widget.text
        : _truncateMarkdown(widget.text, 200);

    final String htmlData = md.markdownToHtml(visibleText);

    return GestureDetector(
      onTap: _toggleExpanded,
      behavior: HitTestBehavior.translucent,
      child: StyledBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSize(
              duration: const Duration(milliseconds: 1000),
              curve: Curves.bounceOut,
              child: Html(
                data: htmlData,
                style: {
                  "body": Style(
                    fontSize: FontSize(18),
                    color: Colors.black87,
                    margin: Margins.zero,
                    textAlign: TextAlign.center,
                  ),
                  "h1": Style(
                    fontSize: FontSize(24),
                    fontWeight: FontWeight.bold,
                  ),
                  "h2": Style(
                    fontSize: FontSize(20),
                    fontWeight: FontWeight.bold,
                  ),
                  "em": Style(fontStyle: FontStyle.italic),
                  "strong": Style(fontWeight: FontWeight.bold),
                },
              ),
            ),
            const SizedBox(),
            Align(
              alignment: Alignment.center,
              child: AnimatedRotation(
                duration: const Duration(milliseconds: 300),
                turns: _expanded ? 0.5 : 0,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.grey.shade300,
                  ),
                  child: const Icon(
                    Icons.expand_more_rounded,
                    size: 24,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _truncateMarkdown(String text, int maxChars) {
    return text.length <= maxChars ? text : '${text.substring(0, maxChars)}...';
  }
}
