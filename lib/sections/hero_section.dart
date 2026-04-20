import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_button.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onBookTap;
  final VoidCallback onExploreTap;

  const HeroSection({
    super.key,
    required this.onBookTap,
    required this.onExploreTap,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> with TickerProviderStateMixin {
  late AnimationController _shimmerController;
  final List<Particle> _particles = List.generate(50, (_) => Particle());

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      height: height,
      width: double.infinity,
      color: AppTheme.darkBg,
      child: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=2070',
              fit: BoxFit.cover,
              color: Colors.black.withOpacity(0.6),
              colorBlendMode: BlendMode.darken,
            ),
          ),
          
          // Background Particles
          Positioned.fill(
            child: CustomPaint(
              painter: ParticlePainter(particles: _particles),
            ),
          ),
          
          // Shimmer Radial Gradient
          AnimatedBuilder(
            animation: _shimmerController,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment(
                      0.5 * sin(_shimmerController.value * 2 * pi),
                      0.5 * cos(_shimmerController.value * 2 * pi),
                    ),
                    colors: [
                      AppTheme.gold.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    radius: 1.5,
                  ),
                ),
              );
            },
          ),

          // Content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Forbes Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: AppTheme.glassDecoration.copyWith(
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star, color: AppTheme.gold, size: 16),
                        const SizedBox(width: 8),
                        Text(
                          'FORBES 5-STAR LUXURY',
                          style: GoogleFonts.poppins(
                            color: AppTheme.gold,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5),

                  const SizedBox(height: 40),

                  // Hotel Name
                  Text(
                    'THE CELESTIAL\nLUMINA',
                    textAlign: TextAlign.center,
                    style: AppTheme.darkTheme.textTheme.displayLarge?.copyWith(
                      fontSize: isMobile ? 48 : 96,
                      height: 1,
                      letterSpacing: 8,
                      shadows: [
                        const Shadow(color: Colors.black, blurRadius: 20),
                      ],
                    ),
                  ).animate().fadeIn(delay: 400.ms, duration: 1000.ms).slideY(begin: 0.2),

                  const SizedBox(height: 24),

                  // Divider
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(width: 60, height: 1, color: AppTheme.gold.withOpacity(0.5)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Transform.rotate(
                          angle: pi / 4,
                          child: Container(width: 8, height: 8, color: AppTheme.gold),
                        ),
                      ),
                      Container(width: 60, height: 1, color: AppTheme.gold.withOpacity(0.5)),
                    ],
                  ).animate().fadeIn(delay: 600.ms).scale(),

                  const SizedBox(height: 24),

                  // Tagline
                  Text(
                    'Where the ocean meets the stars in timeless elegance.',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.playfairDisplay(
                      color: AppTheme.beige,
                      fontSize: isMobile ? 18 : 24,
                      fontStyle: FontStyle.italic,
                    ),
                  ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.2),

                  const SizedBox(height: 60),

                  // CTAs
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    alignment: WrapAlignment.center,
                    children: [
                      AnimatedGoldButton(
                        text: 'Book Your Stay',
                        onPressed: widget.onBookTap,
                      ),
                      AnimatedGoldButton(
                        text: 'Explore Rooms',
                        onPressed: widget.onExploreTap,
                        isSecondary: true,
                      ),
                    ],
                  ).animate().fadeIn(delay: 1000.ms).slideY(begin: 0.2),
                ],
              ),
            ),
          ),

          // Scroll Indicator
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Container(
                  width: 1,
                  height: 60,
                  color: AppTheme.gold.withOpacity(0.3),
                ),
                const SizedBox(height: 12),
                Text(
                  'SCROLL',
                  style: GoogleFonts.poppins(
                    color: AppTheme.gold,
                    fontSize: 10,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ).animate(onPlay: (controller) => controller.repeat(reverse: true))
             .moveY(begin: 0, end: 10, duration: 2000.ms),
          ),
        ],
      ),
    );
  }
}

class Particle {
  double x = Random().nextDouble();
  double y = Random().nextDouble();
  double size = Random().nextDouble() * 2 + 1;
  double speed = Random().nextDouble() * 0.0005 + 0.0002;
  double angle = Random().nextDouble() * 2 * pi;

  void update() {
    x += cos(angle) * speed;
    y += sin(angle) * speed;
    if (x < 0) x = 1;
    if (x > 1) x = 0;
    if (y < 0) y = 1;
    if (y > 1) y = 0;
  }
}

class ParticlePainter extends CustomPainter {
  final List<Particle> particles;
  ParticlePainter({required this.particles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = AppTheme.gold.withOpacity(0.2);
    for (var p in particles) {
      p.update();
      canvas.drawCircle(Offset(p.x * size.width, p.y * size.height), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
