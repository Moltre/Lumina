import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_button.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
  bool _isSubscribed = false;

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.only(top: 100, bottom: 40, left: isMobile ? 20 : 60, right: isMobile ? 20 : 60),
      color: AppTheme.darkBg,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.circle, color: AppTheme.gold, size: 6),
              const SizedBox(width: 8),
              Text(
                'GET IN TOUCH',
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
            'Connect With Us',
            style: AppTheme.darkTheme.textTheme.displayMedium,
          ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
          const SizedBox(height: 80),

          // Contact Cards
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: isMobile ? 1 : (MediaQuery.of(context).size.width < 1200 ? 2 : 4),
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            childAspectRatio: 1.5,
            children: [
              _ContactCard(icon: Icons.location_on, title: 'Visit Us', value: '123 Luxury Way, Star Island, Maldives'),
              _ContactCard(icon: Icons.phone, title: 'Call Us', value: '+1 (800) LUMINA-STAY'),
              _ContactCard(icon: Icons.email, title: 'Email Us', value: 'reservations@lumina-hotel.com'),
              _ContactCard(icon: Icons.access_time, title: 'Hours', value: 'Reception: 24/7 Open'),
            ],
          ),

          const SizedBox(height: 100),

          // Newsletter
          Container(
            width: double.infinity,
            constraints: const BoxConstraints(maxWidth: 800),
            padding: const EdgeInsets.all(60),
            decoration: AppTheme.glassDecoration,
            child: Column(
              children: [
                Text(
                  'Join the Inner Circle',
                  style: GoogleFonts.playfairDisplay(color: Colors.white, fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                Text(
                  'Subscribe to receive exclusive offers and invitations to our signature events.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 16),
                ),
                const SizedBox(height: 40),
                if (_isSubscribed)
                  _buildSubscriptionSuccess()
                else
                  _buildSubscriptionForm(isMobile),
              ],
            ),
          ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1),

          const SizedBox(height: 100),
          const Divider(color: AppTheme.whiteOp20),
          const SizedBox(height: 40),
          _Footer(),
        ],
      ),
    );
  }

  Widget _buildSubscriptionForm(bool isMobile) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(
                color: AppTheme.whiteOp10,
                borderRadius: const BorderRadius.horizontal(left: Radius.circular(30)),
                border: Border.all(color: AppTheme.whiteOp20),
              ),
              child: TextField(
                style: GoogleFonts.poppins(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter your email',
                  hintStyle: GoogleFonts.poppins(color: AppTheme.whiteOp70),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => setState(() => _isSubscribed = true),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.horizontal(right: Radius.circular(30)),
              ),
              alignment: Alignment.center,
              child: Text(
                'SUBSCRIBE',
                style: GoogleFonts.poppins(color: AppTheme.darkBg, fontWeight: FontWeight.bold, letterSpacing: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionSuccess() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check_circle, color: AppTheme.gold, size: 24),
          const SizedBox(width: 12),
          Text(
            'Welcome to the Lumina Inner Circle!',
            style: GoogleFonts.poppins(color: AppTheme.gold, fontWeight: FontWeight.bold),
          ),
        ],
      ).animate().scale(curve: Curves.elasticOut),
    );
  }
}

class _ContactCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;

  const _ContactCard({required this.icon, required this.title, required this.value});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: 300.ms,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppTheme.darkCard,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: _isHovered ? AppTheme.gold : AppTheme.whiteOp10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(widget.icon, color: _isHovered ? AppTheme.gold : AppTheme.whiteOp70, size: 32),
            const SizedBox(height: 16),
            Text(
              widget.title,
              style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1),
            ),
            const SizedBox(height: 8),
            Text(
              widget.value,
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(color: AppTheme.white, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        if (isMobile)
          Column(
            children: [
              _buildFooterBrand(),
              const SizedBox(height: 40),
              _buildFooterSocials(),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildFooterBrand(),
              _buildFooterSocials(),
            ],
          ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _FooterLink('Privacy Policy'),
            _FooterLink('Terms of Service'),
            _FooterLink('Cookie Settings'),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          '© 2026 THE CELESTIAL LUMINA. ALL RIGHTS RESERVED.',
          style: GoogleFonts.poppins(color: AppTheme.whiteOp20, fontSize: 10, letterSpacing: 1),
        ),
      ],
    );
  }

  Widget _buildFooterBrand() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'LUMINA',
          style: GoogleFonts.playfairDisplay(color: AppTheme.gold, fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 4),
        ),
        const SizedBox(height: 12),
        Text(
          'Timeless elegance. Unrivaled luxury.',
          style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 14, fontStyle: FontStyle.italic),
        ),
      ],
    );
  }

  Widget _buildFooterSocials() {
    return Row(
      children: [
        _SocialIcon(Icons.facebook),
        _SocialIcon(Icons.camera_alt),
        _SocialIcon(Icons.alternate_email),
        _SocialIcon(Icons.play_circle_filled),
      ],
    );
  }
}

class _FooterLink extends StatelessWidget {
  final String text;
  const _FooterLink(this.text);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        text,
        style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 12),
      ),
    );
  }
}

class _SocialIcon extends StatefulWidget {
  final IconData icon;
  const _SocialIcon(this.icon);
  @override
  State<_SocialIcon> createState() => _SocialIconState();
}

class _SocialIconState extends State<_SocialIcon> {
  bool _isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Icon(widget.icon, color: _isHovered ? AppTheme.gold : AppTheme.whiteOp70, size: 24),
      ),
    );
  }
}
