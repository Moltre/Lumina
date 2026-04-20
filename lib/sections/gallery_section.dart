import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class GallerySection extends StatelessWidget {
  const GallerySection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 20 : 60),
      color: AppTheme.darkSurface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: AppTheme.gold, size: 6),
              const SizedBox(width: 8),
              Text(
                'VISUAL SPLENDOR',
                style: GoogleFonts.poppins(
                  color: AppTheme.gold,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.circle, color: AppTheme.gold, size: 6),
            ],
          ).animate().fadeIn().slideY(begin: 0.5),
          const SizedBox(height: 16),
          Text(
            'The Gallery',
            style: AppTheme.darkTheme.textTheme.displayMedium,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
          const SizedBox(height: 80),

          if (isMobile)
            Column(
              children: [
                _GalleryItem(title: 'Grand Lobby', icon: Icons.roofing, imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=800'),
                const SizedBox(height: 20),
                _GalleryItem(title: 'Ocean Suite', icon: Icons.waves, imageUrl: 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?auto=format&fit=crop&q=80&w=800'),
                const SizedBox(height: 20),
                _GalleryItem(title: 'Garden Villa', icon: Icons.yard, imageUrl: 'https://images.unsplash.com/photo-1621293954908-907159247ac8?auto=format&fit=crop&q=80&w=800'),
                const SizedBox(height: 20),
                _GalleryItem(title: 'Signature Spa', icon: Icons.spa, imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&q=80&w=800'),
                const SizedBox(height: 20),
                _GalleryItem(title: 'Fine Dining', icon: Icons.restaurant, imageUrl: 'https://images.unsplash.com/photo-1550966841-3ee296a1a47b?auto=format&fit=crop&q=80&w=800'),
                const SizedBox(height: 20),
                _GalleryItem(title: 'Rooftop Pool', icon: Icons.pool, imageUrl: 'https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&q=80&w=800'),
              ],
            )
          else
            Column(
              children: [
                Row(
                  children: [
                    Expanded(flex: 3, child: _GalleryItem(title: 'Grand Lobby', icon: Icons.roofing, imageUrl: 'https://images.unsplash.com/photo-1566073771259-6a8506099945?auto=format&fit=crop&q=80&w=1000')),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _GalleryItem(title: 'Ocean Suite', icon: Icons.waves, imageUrl: 'https://images.unsplash.com/photo-1564501049412-61c2a3083791?auto=format&fit=crop&q=80&w=1000')),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _GalleryItem(title: 'Garden Villa', icon: Icons.yard, imageUrl: 'https://images.unsplash.com/photo-1621293954908-907159247ac8?auto=format&fit=crop&q=80&w=1000')),
                  ],
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(flex: 2, child: _GalleryItem(title: 'Signature Spa', icon: Icons.spa, imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&q=80&w=1000')),
                    const SizedBox(width: 20),
                    Expanded(flex: 2, child: _GalleryItem(title: 'Fine Dining', icon: Icons.restaurant, imageUrl: 'https://images.unsplash.com/photo-1550966841-3ee296a1a47b?auto=format&fit=crop&q=80&w=1000')),
                    const SizedBox(width: 20),
                    Expanded(flex: 3, child: _GalleryItem(title: 'Rooftop Pool', icon: Icons.pool, imageUrl: 'https://images.unsplash.com/photo-1582719508461-905c673771fd?auto=format&fit=crop&q=80&w=1000')),
                  ],
                ),
              ],
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),
        ],
      ),
    );
  }
}

class _GalleryItem extends StatefulWidget {
  final String title;
  final IconData icon;
  final String imageUrl;

  const _GalleryItem({
    required this.title,
    required this.icon,
    required this.imageUrl,
  });

  @override
  State<_GalleryItem> createState() => _GalleryItemState();
}

class _GalleryItemState extends State<_GalleryItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: AnimatedContainer(
          duration: 500.ms,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: _isHovered ? AppTheme.gold : Colors.transparent,
              width: 2,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Background Image
              AnimatedScale(
                scale: _isHovered ? 1.1 : 1.0,
                duration: 800.ms,
                child: Image.network(
                  widget.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Dark Overlay
              AnimatedContainer(
                duration: 500.ms,
                color: _isHovered ? Colors.black.withOpacity(0.7) : Colors.black.withOpacity(0.35),
              ),

              // Content
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.icon,
                      color: AppTheme.whiteOp70,
                      size: 48,
                    ).animate(target: _isHovered ? 1 : 0).scale(end: const Offset(1.2, 1.2)).tint(color: AppTheme.gold),
                    const SizedBox(height: 16),
                    Text(
                      widget.title.toUpperCase(),
                      style: GoogleFonts.playfairDisplay(
                        color: AppTheme.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 12),
                    AnimatedOpacity(
                      duration: 300.ms,
                      opacity: _isHovered ? 1 : 0,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'VIEW DETAILS',
                            style: GoogleFonts.poppins(
                              color: AppTheme.gold,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.add, color: AppTheme.gold, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
