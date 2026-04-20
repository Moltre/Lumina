import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../theme/app_theme.dart';

class AnimatedGoldButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isSecondary;

  const AnimatedGoldButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isSecondary = false,
  });

  @override
  State<AnimatedGoldButton> createState() => _AnimatedGoldButtonState();
}

class _AnimatedGoldButtonState extends State<AnimatedGoldButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          decoration: BoxDecoration(
            gradient: widget.isSecondary ? null : AppTheme.goldGradient,
            color: widget.isSecondary ? Colors.transparent : null,
            borderRadius: BorderRadius.circular(4),
            border: widget.isSecondary ? Border.all(color: AppTheme.gold, width: 2) : null,
            boxShadow: _isHovered && !widget.isSecondary
                ? [
                    BoxShadow(
                      color: AppTheme.gold.withOpacity(0.4),
                      blurRadius: 15,
                      spreadRadius: 2,
                    )
                  ]
                : [],
          ),
          child: Text(
            widget.text.toUpperCase(),
            style: TextStyle(
              color: widget.isSecondary ? AppTheme.gold : AppTheme.darkBg,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              fontSize: 14,
            ),
          ),
        ).animate(target: _isHovered ? 1 : 0).scale(begin: const Offset(1, 1), end: const Offset(1.05, 1.05)),
      ),
    );
  }
}
