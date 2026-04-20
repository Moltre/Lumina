import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';
import '../widgets/animated_button.dart';

class BookingSection extends StatefulWidget {
  const BookingSection({super.key});

  @override
  State<BookingSection> createState() => _BookingSectionState();
}

class _BookingSectionState extends State<BookingSection> {
  bool _isLoading = false;
  bool _isSuccess = false;
  final _formKey = GlobalKey<FormState>();

  DateTime? _checkIn;
  DateTime? _checkOut;
  int _guests = 2;

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _isLoading = false;
        _isSuccess = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 100, horizontal: isMobile ? 20 : 60),
      decoration: const BoxDecoration(
        color: AppTheme.darkBg,
        image: DecorationImage(
          image: NetworkImage('https://images.unsplash.com/photo-1542314831-068cd1dbfeeb?auto=format&fit=crop&q=80&w=2070'),
          fit: BoxFit.cover,
          opacity: 0.1,
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.circle, color: AppTheme.gold, size: 6),
                  const SizedBox(width: 8),
                  Text(
                    'RESERVE YOUR EXPERIENCE',
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
                'Instant Reservation',
                style: AppTheme.darkTheme.textTheme.displayMedium,
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.5),
              const SizedBox(height: 60),
              
              if (_isSuccess)
                _buildSuccessState()
              else
                _buildForm(isMobile),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildForm(bool isMobile) {
    num spacing = isMobile ? 20 : 40;

    return Container(
      padding: EdgeInsets.all(isMobile ? 20 : 60),
      decoration: AppTheme.glassDecoration,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Personal Details
            Text(
              'PERSONAL DETAILS',
              style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: _buildTextField(label: 'Full Name', icon: Icons.person)),
                if (!isMobile) ...[
                  const SizedBox(width: 30),
                  Expanded(child: _buildTextField(label: 'Email Address', icon: Icons.email)),
                ],
              ],
            ),
            if (isMobile) ...[
              const SizedBox(height: 20),
              _buildTextField(label: 'Email Address', icon: Icons.email),
            ],

            const SizedBox(height: 40),
            
            // Row 2: Dates & Guests
            Text(
              'RESERVATION DETAILS',
              style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2),
            ),
            const SizedBox(height: 24),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: isMobile ? 1 : 3,
              childAspectRatio: isMobile ? 4 : 2,
              crossAxisSpacing: 30,
              mainAxisSpacing: 20,
              children: [
                _buildDatePicker(
                  label: 'Check-In',
                  value: _checkIn,
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      builder: (context, child) => Theme(data: AppTheme.darkTheme, child: child!),
                    );
                    if (d != null) setState(() => _checkIn = d);
                  },
                ),
                _buildDatePicker(
                  label: 'Check-Out',
                  value: _checkOut,
                  onTap: () async {
                    final d = await showDatePicker(
                      context: context,
                      initialDate: _checkIn?.add(const Duration(days: 1)) ?? DateTime.now().add(const Duration(days: 1)),
                      firstDate: _checkIn?.add(const Duration(days: 1)) ?? DateTime.now().add(const Duration(days: 1)),
                      lastDate: DateTime.now().add(const Duration(days: 400)),
                      builder: (context, child) => Theme(data: AppTheme.darkTheme, child: child!),
                    );
                    if (d != null) setState(() => _checkOut = d);
                  },
                ),
                _buildGuestCounter(),
              ],
            ),
            
            const SizedBox(height: 40),
            
            // Special Requests
            _buildTextField(label: 'Special Requests (Optional)', icon: Icons.notes, maxLines: 3),
            
            const SizedBox(height: 60),
            
            Center(
              child: Column(
                children: [
                  if (_isLoading)
                    const CircularProgressIndicator(color: AppTheme.gold)
                  else
                    AnimatedGoldButton(text: 'Confirm Reservation', onPressed: _submit),
                  
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.lock_outline, color: AppTheme.whiteOp70, size: 14),
                      const SizedBox(width: 8),
                      Text(
                        'SECURE BOOKING • FREE CANCELLATION UP TO 24H',
                        style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 10, letterSpacing: 1),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).animate().fadeIn(delay: 400.ms),
      ),
    );
  }

  Widget _buildTextField({required String label, required IconData icon, int maxLines = 1}) {
    return TextFormField(
      maxLines: maxLines,
      style: GoogleFonts.poppins(color: AppTheme.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 14),
        prefixIcon: Icon(icon, color: AppTheme.gold, size: 20),
        filled: true,
        fillColor: AppTheme.whiteOp10,
        enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.whiteOp20), borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: AppTheme.gold), borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      ),
    );
  }

  Widget _buildDatePicker({required String label, DateTime? value, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        decoration: BoxDecoration(
          color: AppTheme.whiteOp10,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.whiteOp20),
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_month, color: AppTheme.gold, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(label, style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 10)),
                Text(
                  value == null ? 'Select Date' : '${value.day}/${value.month}/${value.year}',
                  style: GoogleFonts.poppins(color: AppTheme.white, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGuestCounter() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.whiteOp10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.whiteOp20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Icon(Icons.people, color: AppTheme.gold, size: 20),
          Text('GUESTS', style: GoogleFonts.poppins(color: AppTheme.gold, fontSize: 10)),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: AppTheme.gold, size: 20),
                onPressed: () => setState(() => _guests = (_guests > 1) ? _guests - 1 : 1),
              ),
              Text('$_guests', style: GoogleFonts.poppins(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add_circle_outline, color: AppTheme.gold, size: 20),
                onPressed: () => setState(() => _guests++),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSuccessState() {
    return Container(
      padding: const EdgeInsets.all(60),
      decoration: AppTheme.glassDecoration,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: AppTheme.gold, shape: BoxShape.circle),
            child: const Icon(Icons.check, color: AppTheme.darkBg, size: 40),
          ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
          const SizedBox(height: 32),
          Text(
            'Reservation Confirmed!',
            style: GoogleFonts.playfairDisplay(color: AppTheme.white, fontSize: 32, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            'Your luxury experience is waiting. A confirmation email has been sent.',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(color: AppTheme.whiteOp70, fontSize: 16),
          ),
          const SizedBox(height: 48),
          AnimatedGoldButton(
            text: 'Make Another Booking',
            onPressed: () => setState(() => _isSuccess = false),
          ),
        ],
      ),
    ).animate().fadeIn();
  }
}
