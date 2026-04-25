import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_generator/screens/domain_screen.dart';
import '../core/constants.dart';
import 'student_screen.dart';


class HubScreen extends StatelessWidget {
  const HubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 40),
              Text("GENERATION HUB", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.onSurfaceVariant, letterSpacing: 1.2)),
              const SizedBox(height: 8),
              Text("What will you\ncreate today?", style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w900, fontSize: 32, color: AppColors.textMain, height: 1.1)),
              const SizedBox(height: 40),
              _buildMenuCard(context, "Student Information", "Generate academic ID codes for enrollment.", Icons.person, const StudentScreen()),
              const SizedBox(height: 20),
              _buildMenuCard(context, "Domain Links", "Convert any URL into a visual gateway.", Icons.language, const DomainScreen()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, String title, String sub, IconData icon, Widget target) {
    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(color: Colors.white.withOpacity(0.6), borderRadius: BorderRadius.circular(32), border: Border.all(color: Colors.white, width: 2)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: AppColors.primary, size: 30),
            const SizedBox(height: 20),
            Text(title, style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.bold, fontSize: 20, color: AppColors.textMain)),
            const SizedBox(height: 8),
            Text(sub, style: const TextStyle(color: AppColors.onSurfaceVariant, fontSize: 14)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => target)),
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
              child: const Text("Begin Design", style: TextStyle(color: Colors.white)),
            )
          ],
        ),
      ),
    );
  }
}