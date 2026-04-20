import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'theme/app_theme.dart';
import 'widgets/navbar.dart';
import 'sections/hero_section.dart';
import 'sections/rooms_section.dart';
import 'sections/amenities_section.dart';
import 'sections/gallery_section.dart';
import 'sections/booking_section.dart';
import 'sections/testimonials_section.dart';
import 'sections/contact_section.dart';

void main() {
  runApp(const LuxuryHotelApp());
}

class LuxuryHotelApp extends StatelessWidget {
  const LuxuryHotelApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'The Celestial Lumina | Luxury Hotel',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _progress = 0;

  @override
  void initState() {
    super.initState();
    _simulateLoading();
  }

  void _simulateLoading() async {
    for (int i = 0; i <= 100; i++) {
      await Future.delayed(const Duration(milliseconds: 30));
      if (mounted) setState(() => _progress = i / 100);
    }
    await Future.delayed(const Duration(milliseconds: 500));
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: 1000.ms,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.darkBg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'LUMINA',
              style: GoogleFonts.playfairDisplay(
                color: AppTheme.gold,
                fontSize: 64,
                fontWeight: FontWeight.bold,
                letterSpacing: 12,
              ),
            ).animate()
             .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1), duration: 2000.ms, curve: Curves.elasticOut),
            
            const SizedBox(height: 40),
            
            SizedBox(
              width: 200,
              child: Column(
                children: [
                  LinearProgressIndicator(
                    value: _progress,
                    backgroundColor: AppTheme.whiteOp10,
                    color: AppTheme.gold,
                    minHeight: 2,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${(_progress * 100).toInt()}%',
                    style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, letterSpacing: 2),
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 24),
            Text(
              'Preparing your luxury experience...',
              style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 14, fontStyle: FontStyle.italic),
            ).animate(onPlay: (c) => c.repeat(reverse: true)).fadeIn(duration: 1000.ms),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  bool _isScrolled = false;

  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _roomsKey = GlobalKey();
  final GlobalKey _amenitiesKey = GlobalKey();
  final GlobalKey _galleryKey = GlobalKey();
  final GlobalKey _bookingKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 50 && !_isScrolled) {
        setState(() => _isScrolled = true);
      } else if (_scrollController.offset <= 50 && _isScrolled) {
        setState(() => _isScrolled = false);
      }
    });
  }

  void _scrollToSection(int index) {
    GlobalKey key;
    switch (index) {
      case 0: key = _heroKey; break;
      case 1: key = _roomsKey; break;
      case 2: key = _amenitiesKey; break;
      case 3: key = _galleryKey; break;
      case 4: key = _bookingKey; break;
      default: return;
    }

    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: 800.ms,
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: _buildMobileDrawer(),
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: _heroKey,
                  onBookTap: () => _scrollToSection(4),
                  onExploreTap: () => _scrollToSection(1),
                ),
                RoomsSection(key: _roomsKey),
                AmenitiesSection(key: _amenitiesKey),
                GallerySection(key: _galleryKey),
                BookingSection(key: _bookingKey),
                const TestimonialsSection(),
                const ContactSection(),
              ],
            ),
          ),
          
          // Sticky Navbar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Navbar(
              isScrolled: _isScrolled,
              onNavTap: _scrollToSection,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileDrawer() {
    return Drawer(
      backgroundColor: AppTheme.darkBg,
      child: Container(
        padding: const EdgeInsets.all(40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'LUMINA',
              style: GoogleFonts.playfairDisplay(color: AppTheme.gold, fontSize: 32, fontWeight: FontWeight.bold, letterSpacing: 4),
            ),
            const SizedBox(height: 60),
            _DrawerItem(label: 'HOME', onTap: () { Navigator.pop(context); _scrollToSection(0); }),
            _DrawerItem(label: 'ROOMS', onTap: () { Navigator.pop(context); _scrollToSection(1); }),
            _DrawerItem(label: 'AMENITIES', onTap: () { Navigator.pop(context); _scrollToSection(2); }),
            _DrawerItem(label: 'GALLERY', onTap: () { Navigator.pop(context); _scrollToSection(3); }),
            _DrawerItem(label: 'BOOKING', onTap: () { Navigator.pop(context); _scrollToSection(4); }),
            const Spacer(),
            const Divider(color: AppTheme.whiteOp20),
            const SizedBox(height: 20),
            Text(
              'RESERVATIONS@LUMINA.COM',
              style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, letterSpacing: 1),
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const _DrawerItem({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: InkWell(
        onTap: onTap,
        child: Text(
          label,
          style: GoogleFonts.poppins(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2),
        ),
      ),
    );
  }
}
