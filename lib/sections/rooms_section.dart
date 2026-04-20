import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../theme/app_theme.dart';

class RoomsSection extends StatelessWidget {
  const RoomsSection({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;
    bool isTablet = MediaQuery.of(context).size.width < 1100 && !isMobile;

    final List<RoomData> rooms = [
      RoomData(
        name: 'Deluxe King Room',
        price: 37500,
        size: 52,
        badge: 'POPULAR',
        description: 'Immaculate design meets unparalleled comfort in our signature king suite.',
        amenities: ['King Bed', 'City View', 'Whirlpool'],
        imageUrl: 'https://images.unsplash.com/photo-1611892440504-42a792e24d32?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF1A1A1A), Color(0xFF0D0D0D)],
      ),
      RoomData(
        name: 'Premium Ocean Suite',
        price: 62000,
        size: 88,
        badge: 'BEST VALUE',
        description: 'Breathtaking panoramic views of the horizon with a private balcony.',
        amenities: ['Ocean View', 'Mini Bar', '24/7 Service'],
        imageUrl: 'https://images.unsplash.com/photo-1590490360182-c33d57733427?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF1A222E), Color(0xFF0D1117)],
      ),
      RoomData(
        name: 'Royal Penthouse',
        price: 150000,
        size: 220,
        badge: 'EXCLUSIVE',
        description: 'The pinnacle of luxury. Private pool, cinema, and dedicated staff.',
        amenities: ['Private Pool', 'Chef', 'Cinema'],
        imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF2E1A1A), Color(0xFF170D0D)],
      ),
      RoomData(
        name: 'Garden Villa',
        price: 80000,
        size: 150,
        badge: 'NEW',
        description: 'A secluded sanctuary surrounded by lush tropical gardens and waterfalls.',
        amenities: ['Garden', 'Fireplace', 'Rain Shower'],
        imageUrl: 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF1A2E1A), Color(0xFF0D170D)],
      ),
      RoomData(
        name: 'Classic Twin Room',
        price: 26500,
        size: 44,
        badge: 'COMFORT',
        description: 'Timeless elegance and practical luxury for shared stays.',
        amenities: ['Twin Beds', 'Desk', 'Smart TV'],
        imageUrl: 'https://images.unsplash.com/photo-1566665797739-1674de7a421a?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF1A1A1A), Color(0xFF0A0A0A)],
      ),
      RoomData(
        name: 'Honeymoon Suite',
        price: 100000,
        size: 95,
        badge: 'ROMANTIC',
        description: 'Celebrate your love in an intimate setting with champagne service.',
        amenities: ['Champagne', 'Petals', 'Spa Bath'],
        imageUrl: 'https://images.unsplash.com/photo-1591088398332-8a77d3996182?auto=format&fit=crop&q=80&w=1000',
        gradient: const [Color(0xFF2E1A2E), Color(0xFF170D17)],
      ),
    ];

    return VisibilityDetector(
      key: const Key('rooms-section'),
      onVisibilityChanged: (_) {},
      child: Container(
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
                  'EXQUISITE STAYS',
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
              'Rooms & Suites',
              style: AppTheme.darkTheme.textTheme.displayMedium,
            ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
            const SizedBox(height: 80),

            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: isMobile ? 1 : (isTablet ? 2 : 3),
                crossAxisSpacing: 30,
                mainAxisSpacing: 30,
                childAspectRatio: 0.7,
              ),
              itemCount: rooms.length,
              itemBuilder: (context, index) {
                return RoomCard(room: rooms[index])
                    .animate()
                    .fadeIn(delay: (200 * index).ms)
                    .slideY(begin: 0.2);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class RoomCard extends StatefulWidget {
  final RoomData room;
  const RoomCard({super.key, required this.room});

  @override
  State<RoomCard> createState() => _RoomCardState();
}

class _RoomCardState extends State<RoomCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: 400.ms,
        transform: Matrix4.identity()..translate(0, _isHovered ? -12 : 0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: AppTheme.darkCard,
          border: Border.all(
            color: _isHovered ? AppTheme.gold.withOpacity(0.5) : AppTheme.whiteOp10,
            width: 1,
          ),
          boxShadow: _isHovered
              ? [BoxShadow(color: AppTheme.gold.withOpacity(0.15), blurRadius: 30, spreadRadius: 2)]
              : [],
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            Expanded(
              flex: 4,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  AnimatedScale(
                    scale: _isHovered ? 1.1 : 1.0,
                    duration: 800.ms,
                    child: Image.network(
                      widget.room.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(color: AppTheme.darkCard),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, AppTheme.darkCard.withOpacity(0.8)],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.gold.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        widget.room.badge,
                        style: GoogleFonts.poppins(color: AppTheme.darkBg, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Content Section
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.room.size} m²',
                      style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      widget.room.name,
                      style: GoogleFonts.playfairDisplay(color: AppTheme.white, fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.room.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 13, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: widget.room.amenities.map((a) => _AmenityChip(label: a)).toList(),
                    ),
                    const Spacer(),
                    const Divider(color: AppTheme.whiteOp10),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '₹ ${widget.room.price.toInt()}',
                              style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '/ night',
                              style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 10),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          decoration: BoxDecoration(
                            color: _isHovered ? AppTheme.gold : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(color: AppTheme.gold),
                          ),
                          child: Text(
                            'RESERVE',
                            style: GoogleFonts.poppins(
                              color: _isHovered ? AppTheme.darkBg : AppTheme.gold,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  final String label;
  const _AmenityChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.whiteOp10,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 9),
      ),
    );
  }
}

class RoomData {
  final String name;
  final double price;
  final double size;
  final String badge;
  final String description;
  final List<String> amenities;
  final String imageUrl;
  final List<Color> gradient;

  RoomData({
    required this.name,
    required this.price,
    required this.size,
    required this.badge,
    required this.description,
    required this.amenities,
    required this.imageUrl,
    required this.gradient,
  });
}
