import 'package:flutter/material.dart';

class SlideTransitionCard extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  const SlideTransitionCard({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = Duration.zero,
  });

  @override
  State<SlideTransitionCard> createState() => _SlideTransitionCardState();
}

class _SlideTransitionCardState extends State<SlideTransitionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(vsync: this, duration: widget.duration);

    _offsetAnimation = Tween<Offset>(
      begin: const Offset(1, 0), // desde la derecha
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(position: _offsetAnimation, child: widget.child);
  }
}
