import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../theme/app_theme.dart';

class TestimonialsSection extends StatefulWidget {
  const TestimonialsSection({super.key});

  @override
  State<TestimonialsSection> createState() => _TestimonialsSectionState();
}

class _TestimonialsSectionState extends State<TestimonialsSection> {
  final PageController _pageController = PageController(viewportFraction: 0.8);
  int _currentPage = 0;

  final List<TestimonialData> testimonials = [
    TestimonialData(
      name: 'Alexander Sterling',
      location: 'London, UK',
      text: 'An absolute masterpiece of hospitality. The attention to detail in the Royal Penthouse is unlike anything I have experienced in my travels.',
      imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?auto=format&fit=crop&q=80&w=200',
    ),
    TestimonialData(
      name: 'Elena Rodriguez',
      location: 'Madrid, Spain',
      text: 'The Celestial Lumina captures the essence of luxury. The infinity pool at sunset is a memory I will cherish forever.',
      imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=200',
    ),
    TestimonialData(
      name: 'James Chen',
      location: 'Singapore',
      text: 'Exquisite dining and impeccable service. The butler was always one step ahead, making our stay truly effortless.',
      imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&q=80&w=200',
    ),
    TestimonialData(
      name: 'Sophia Laurent',
      location: 'Paris, France',
      text: 'From the moment we arrived at the Grand Lobby, we knew we were in for something special. Pure elegance.',
      imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&q=80&w=200',
    ),
    TestimonialData(
      name: 'Marcus Thorne',
      location: 'New York, USA',
      text: 'The Garden Villa is a private sanctuary. It felt like we were the only people on earth in a lush paradise.',
      imageUrl: 'https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?auto=format&fit=crop&q=80&w=200',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      int next = _pageController.page!.round();
      if (_currentPage != next) {
        setState(() => _currentPage = next);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100),
      color: AppTheme.darkSurface,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: AppTheme.gold, size: 6),
              const SizedBox(width: 8),
              Text(
                'GUEST VOICES',
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
            'Reflections of Excellence',
            textAlign: TextAlign.center,
            style: AppTheme.darkTheme.textTheme.displayMedium,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
          const SizedBox(height: 80),

          SizedBox(
            height: isMobile ? 500 : 450,
            child: PageView.builder(
              controller: _pageController,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                bool isActive = index == _currentPage;
                return AnimatedScale(
                  scale: isActive ? 1.0 : 0.9,
                  duration: 500.ms,
                  child: TestimonialCard(
                    data: testimonials[index],
                    isActive: isActive,
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 40),

          SmoothPageIndicator(
            controller: _pageController,
            count: testimonials.length,
            effect: ExpandingDotsEffect(
              activeDotColor: AppTheme.gold,
              dotColor: AppTheme.whiteOp20,
              dotHeight: 8,
              dotWidth: 8,
              expansionFactor: 4,
            ),
          ),

          const SizedBox(height: 40),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _NavButton(
                icon: Icons.arrow_back,
                onPressed: () => _pageController.previousPage(duration: 500.ms, curve: Curves.easeInOut),
              ),
              const SizedBox(width: 20),
              _NavButton(
                icon: Icons.arrow_forward,
                onPressed: () => _pageController.nextPage(duration: 500.ms, curve: Curves.easeInOut),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class TestimonialCard extends StatelessWidget {
  final TestimonialData data;
  final bool isActive;

  const TestimonialCard({super.key, required this.data, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: AppTheme.darkCard,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: isActive ? AppTheme.gold : AppTheme.whiteOp10,
          width: 1,
        ),
        boxShadow: isActive
            ? [BoxShadow(color: AppTheme.gold.withOpacity(0.1), blurRadius: 30, spreadRadius: 5)]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.format_quote, color: AppTheme.gold, size: 64),
          const SizedBox(height: 20),
          Text(
            '"${data.text}"',
            textAlign: TextAlign.center,
            style: GoogleFonts.playfairDisplay(
              color: AppTheme.white,
              fontSize: 20,
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (_) => const Icon(Icons.star, color: AppTheme.gold, size: 20)),
          ),
          const SizedBox(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppTheme.gold),
                  image: DecorationImage(
                    image: NetworkImage(data.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: GoogleFonts.poppins(color: AppTheme.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(
                    data.location,
                    style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatefulWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _NavButton({required this.icon, required this.onPressed});

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: AnimatedContainer(
          duration: 300.ms,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _isHovered ? AppTheme.gold : Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(color: AppTheme.gold),
          ),
          child: Icon(
            widget.icon,
            color: _isHovered ? AppTheme.darkBg : AppTheme.gold,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class TestimonialData {
  final String name;
  final String location;
  final String text;
  final String imageUrl;
  TestimonialData({required this.name, required this.location, required this.text, required this.imageUrl});
}
