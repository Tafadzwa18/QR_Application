import 'package:flutter/material.dart';
import 'package:qr_generator/core/constants.dart';
import 'package:qr_generator/widgets/custom_widgets.dart';

import 'package:screenshot/screenshot.dart';
class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});
  @override
  _StudentScreenState createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  final _nameController = TextEditingController();
  final _classController = TextEditingController();
  final _screenshotController = ScreenshotController();
  String _qrData = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context, "Student Info"),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            buildInputField("STUDENT NAME", "Enter full name", _nameController),
            const SizedBox(height: 20),
            buildInputField("CLASS", "e.g. Grade 7-A", _classController),
            const SizedBox(height: 32),
            _buildActionBtn(),
            if (_qrData.isNotEmpty) buildQRDisplay(_qrData, _screenshotController, context),
          ],
        ),
      ),
    );
  }

  Widget _buildActionBtn() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, shape: StadiumBorder()),
        onPressed: () => setState(() => _qrData = "Name: ${_nameController.text}, Class: ${_classController.text}"),
        child: const Text("Generate QR Code", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );
  }
}