import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class AmenitiesSection extends StatelessWidget {
  const AmenitiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    final List<AmenityData> amenities = [
      AmenityData(
        icon: Icons.spa, 
        title: 'World-Class Spa', 
        desc: 'Indulge in ancient healing rituals and modern wellness treatments.',
        imageUrl: 'https://images.unsplash.com/photo-1544161515-4ab6ce6db874?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.pool, 
        title: 'Infinity Pool', 
        desc: 'A seamless horizon of azure waters suspended between sky and sea.',
        imageUrl: 'https://images.unsplash.com/photo-1576013551627-0cc20b96c2a7?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.restaurant, 
        title: 'Fine Dining', 
        desc: 'Michelin-starred excellence curated by world-renowned chefs.',
        imageUrl: 'https://images.unsplash.com/photo-1514362545857-3bc16c4c7d1b?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.fitness_center, 
        title: 'Fitness Center', 
        desc: 'State-of-the-art equipment with personalized training 24/7.',
        imageUrl: 'https://images.unsplash.com/photo-1540497077202-7c8a3999166f?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.wifi, 
        title: 'Ultra-Fast WiFi', 
        desc: 'Dedicated 10Gbps connection for seamless global connectivity.',
        imageUrl: 'https://images.unsplash.com/photo-1563986768609-322da13575f3?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.nightlife, 
        title: 'Rooftop Bar', 
        desc: 'Signature cocktails with breathtaking 360-degree city views.',
        imageUrl: 'https://images.unsplash.com/photo-1574096079513-d8259312b785?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.directions_car, 
        title: 'Valet Service', 
        desc: 'Complimentary luxury vehicle handling and secure parking.',
        imageUrl: 'https://images.unsplash.com/photo-1619642751034-765dfdf7c58e?auto=format&fit=crop&q=80&w=600',
      ),
      AmenityData(
        icon: Icons.person, 
        title: '24/7 Butler Service', 
        desc: 'Discreet and personalized assistance for every whim and need.',
        imageUrl: 'https://images.unsplash.com/photo-1517486808906-6ca8b3f04846?auto=format&fit=crop&q=80&w=600',
      ),
    ];

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 20 : 60),
      color: AppTheme.darkBg,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: AppTheme.gold, size: 6),
              const SizedBox(width: 8),
              Text(
                'UNRIVALED COMFORT',
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
            'World-Class Amenities',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.displayMedium,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
          const SizedBox(height: 80),
          
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isMobile ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 4),
              crossAxisSpacing: 30,
              mainAxisSpacing: 30,
              childAspectRatio: 0.9,
            ),
            itemCount: amenities.length,
            itemBuilder: (context, index) {
              return AmenityCard(data: amenities[index])
                  .animate()
                  .fadeIn(delay: (100 * index).ms)
                  .scale(begin: const Offset(0.9, 0.9));
            },
          ),

          const SizedBox(height: 100),

          // Stats row
          Wrap(
            spacing: 60,
            runSpacing: 40,
            alignment: WrapAlignment.center,
            children: [
              _StatItem(number: '500+', label: 'Luxury Rooms'),
              _StatItem(number: '25', label: 'Years of Excellence'),
              _StatItem(number: '98%', label: 'Guest Satisfaction'),
              _StatItem(number: '12', label: 'Awards Won'),
            ],
          ),
        ],
      ),
    );
  }
}

class AmenityCard extends StatefulWidget {
  final AmenityData data;
  const AmenityCard({super.key, required this.data});

  @override
  State<AmenityCard> createState() => _AmenityCardState();
}

class _AmenityCardState extends State<AmenityCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        decoration: BoxDecoration(
          color: AppTheme.darkCard,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: _isHovered ? AppTheme.gold.withOpacity(0.5) : AppTheme.whiteOp10,
            width: 1,
          ),
          image: DecorationImage(
            image: NetworkImage(widget.data.imageUrl),
            fit: BoxFit.cover,
            opacity: _isHovered ? 0.4 : 0.2,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.gold.withOpacity(0.1), blurRadius: 20, spreadRadius: 2)]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.transparent, Colors.black.withOpacity(0.8)],
            ),
          ),
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: _isHovered ? AppTheme.gold : AppTheme.whiteOp10,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  widget.data.icon,
                  color: _isHovered ? AppTheme.darkBg : AppTheme.white,
                  size: 28,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.data.title,
                textAlign: TextAlign.center,
                style: GoogleFonts.playfairDisplay(
                  color: AppTheme.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                widget.data.desc,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: AppTheme.whiteOp70,
                  fontSize: 12,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String number;
  final String label;
  const _StatItem({required this.number, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          shaderCallback: (bounds) => AppTheme.goldGradient.createShader(bounds),
          child: Text(
            number,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 48,
              fontWeight: FontWeight.bold,
            ),
          ),
        ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
        const SizedBox(height: 8),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.poppins(
            color: AppTheme.gold,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}

class AmenityData {
  final IconData icon;
  final String title;
  final String desc;
  final String imageUrl;
  AmenityData({required this.icon, required this.title, required this.desc, required this.imageUrl});
}
