import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_generator/core/constants.dart';
import 'package:screenshot/screenshot.dart';

// Reusable Appbar
PreferredSizeWidget buildAppBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: const Icon(Icons.arrow_back, color: AppColors.primary),
    ),

    title: Text(title, style: GoogleFonts.plusJakartaSans(color: AppColors.textMain, fontWeight: FontWeight.bold, fontSize: 18)),
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 20),
        child: Center(child: Text("Digital Footprint", style: GoogleFonts.plusJakartaSans(color: AppColors.primary, fontWeight: FontWeight.w900))),
        )
    ],
  );
}

//Reusable Input Field
Widget buildInputField(String label, String hint, TextEditingController controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppColors.onSurfaceVariant)),
      const SizedBox(height: 10),
      TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: hint,
          filled: true,
          fillColor: AppColors.inputFill,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.all(20),
        ),
      ),
    ],
  );
}

// Reusable QR display & Download Card
Widget buildQRDisplay(String data, ScreenshotController controller, BuildContext context) {
  return Column(
    children: [
      const SizedBox(height: 40),
      Screenshot(
        controller: controller,
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(24)),
          child: QrImageView(data: data, size: 200, version: QrVersions.auto),
        ),
      ),
      const SizedBox(height: 20),
      TextButton.icon(
        onPressed: () async {
          final image = await controller.capture();
          if (image != null) {
            await ImageGallerySaver.saveImage(image, name: "QR_${DateTime.now().millisecond}");
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Saved to Gallery!")));
          }
        },
        icon: const Icon(Icons.download, color: AppColors.primary),
        label: const Text("Download Image", style: TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold)),
      )
    ],
  );
}