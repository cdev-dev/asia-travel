import 'package:flutter/material.dart';

class FloatingActionButtonsWidget extends StatefulWidget {
  final VoidCallback? onSharePressed;
  final VoidCallback? onFavoritePressed;

  const FloatingActionButtonsWidget({
    super.key,
    this.onSharePressed,
    this.onFavoritePressed,
  });

  @override
  FloatingActionButtonsWidgetState createState() =>
      FloatingActionButtonsWidgetState();
}

class FloatingActionButtonsWidgetState
    extends State<FloatingActionButtonsWidget>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animationOpacity;

  // Controlador para animar el icono compartir al pulsar
  late AnimationController _shareTapController;
  late Animation<double> _shareScaleAnimation;

  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _animationOpacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.forward();

    _shareTapController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      lowerBound: 0.8,
      upperBound: 1.0,
      value: 1.0,
    );

    _shareScaleAnimation = _shareTapController.drive(
      Tween<double>(begin: 1.0, end: 0.8),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _shareTapController.dispose();
    super.dispose();
  }

  Widget _smallIconButton({
    required Widget icon,
    required VoidCallback? onPressed,
    required String tooltip,
    VoidCallback? onTapDown,
    VoidCallback? onTapUp,
  }) {
    return Material(
      color: Colors.white.withAlpha(230),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onPressed,
        onTapDown: (_) => onTapDown?.call(),
        onTapUp: (_) => onTapUp?.call(),
        onTapCancel: onTapUp,
        child: Padding(padding: const EdgeInsets.all(8), child: icon),
      ),
    );
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
    if (widget.onFavoritePressed != null) {
      widget.onFavoritePressed!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animationOpacity,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _smallIconButton(
            icon: ScaleTransition(
              scale: _shareScaleAnimation,
              child: const Icon(
                Icons.share,
                key: ValueKey('share_icon'),
                size: 20,
                color: Colors.black87,
              ),
            ),
            onPressed: () {
              widget.onSharePressed?.call();
            },
            onTapDown: () {
              _shareTapController.reverse();
            },
            onTapUp: () {
              _shareTapController.forward();
            },
            tooltip: 'Compartir',
          ),
          const SizedBox(width: 12),
          _smallIconButton(
            icon: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                key: ValueKey<bool>(_isFavorite),
                size: 20,
                color: _isFavorite ? Colors.red : Colors.black87,
              ),
            ),
            onPressed: _toggleFavorite,
            tooltip: 'Favorito',
          ),
        ],
      ),
    );
  }
}
