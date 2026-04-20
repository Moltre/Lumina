import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import 'animated_button.dart';

class Navbar extends StatefulWidget {
  final bool isScrolled;
  final Function(int) onNavTap;

  const Navbar({
    super.key,
    required this.isScrolled,
    required this.onNavTap,
  });

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return AnimatedContainer(
      duration: 300.ms,
      height: widget.isScrolled ? 80 : 100,
      decoration: BoxDecoration(
        color: widget.isScrolled ? AppTheme.darkBg.withOpacity(0.8) : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: widget.isScrolled ? AppTheme.whiteOp20 : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.isScrolled ? 10 : 0, sigmaY: widget.isScrolled ? 10 : 0),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 60),
            child: Row(
              children: [
                // Logo
                Text(
                  'LUMINA',
                  style: GoogleFonts.playfairDisplay(
                    color: AppTheme.gold,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 4,
                  ),
                ).animate().fadeIn(duration: 800.ms).slideX(begin: -0.2),
                const Spacer(),
                
                if (!isMobile) ...[
                  _NavItem(label: 'Home', onTap: () => widget.onNavTap(0)),
                  _NavItem(label: 'Rooms', onTap: () => widget.onNavTap(1)),
                  _NavItem(label: 'Amenities', onTap: () => widget.onNavTap(2)),
                  _NavItem(label: 'Gallery', onTap: () => widget.onNavTap(3)),
                  _NavItem(label: 'Booking', onTap: () => widget.onNavTap(4)),
                  const SizedBox(width: 40),
                  AnimatedGoldButton(
                    text: 'Book Now',
                    onPressed: () => widget.onNavTap(4),
                  ),
                ] else ...[
                  IconButton(
                    icon: const Icon(Icons.menu, color: AppTheme.gold, size: 30),
                    onPressed: () {
                      Scaffold.of(context).openEndDrawer();
                    },
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const _NavItem({required this.label, required this.onTap});

  @override
  State<_NavItem> createState() => _NavItemState();
}

class _NavItemState extends State<_NavItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  color: _isHovered ? AppTheme.gold : AppTheme.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: 300.ms,
                height: 2,
                width: _isHovered ? 20 : 0,
                color: AppTheme.gold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
