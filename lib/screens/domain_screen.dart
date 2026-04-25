import 'package:flutter/material.dart';
import 'package:screenshot/screenshot.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/custom_widgets.dart';
import '../core/constants.dart';

class DomainScreen extends StatefulWidget {
  const DomainScreen({super.key});

  @override
  _DomainScreenState createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  final _domainController = TextEditingController();
  final _screenshotController = ScreenshotController();
  String _qrData = "";

  @override
  void dispose() {
    _domainController.dispose();
    super.dispose();
  }

  void _handleGeneration() {
    if (_domainController.text.isNotEmpty) {
      setState(() {
        _qrData = _domainController.text;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid domain or URL")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Domain Link"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero Section for this screen
            Text(
              "QR CREATION",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 10,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.5,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              "Transform your\nDomain",
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.w800,
                fontSize: 32,
                color: AppColors.textMain,
                height: 1.1,
              ),
            ),
            const SizedBox(height: 32),

            // Reusable Input Component
            buildInputField(
              "WEBSITE DOMAIN", 
              "www.yoursite.com", 
              _domainController
            ),
            
            const SizedBox(height: 32),

            // Generation Button
            _buildActionBtn(),

            // QR Display Area
            if (_qrData.isNotEmpty) 
              buildQRDisplay(_qrData, _screenshotController, context),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn() {
    return Container(
      width: double.infinity,
      height: 64,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, AppColors.primaryDim],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          )
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: _handleGeneration,
        icon: const Icon(Icons.qr_code_2, color: Colors.white),
        label: const Text(
          "Generate QR Code",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
        ),
      ),
    );
  }
}