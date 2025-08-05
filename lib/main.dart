import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Code Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: const QRCodeGeneratorPage(),
    );
  }
}

class QRCodeGeneratorPage extends StatefulWidget {
  const QRCodeGeneratorPage({super.key});

  @override
  State<QRCodeGeneratorPage> createState() => _QRCodeGeneratorPageState();
}

class _QRCodeGeneratorPageState extends State<QRCodeGeneratorPage> {
  final TextEditingController _studentNameController = TextEditingController();
  final TextEditingController _studentClassController = TextEditingController();
  final TextEditingController _domainNameController = TextEditingController();

  String _qrData = 'Enter data to generate QR code';

  @override
  void dispose(){
    _studentNameController.dispose();
    _studentClassController.dispose();
    _domainNameController.dispose();
    super.dispose();
  }

  void _generateStudentQR(){
    if(_studentNameController.text.isNotEmpty && _studentClassController.text.isNotEmpty){
      setState(() {
        _qrData = "Student: ${_studentNameController.text}, Class: ${_studentClassController.text}";
      });
    }
  }

  void _generateDomainQR(){
    if(_domainNameController.text.isNotEmpty){
      setState(() {
        _qrData = _domainNameController.text;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Student QR Code section
            Text(
              'Generate Student QR Code',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _studentNameController,
              decoration: const InputDecoration(
                labelText: 'Student Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _studentClassController,
              decoration: const InputDecoration(
                labelText: 'Student Class (e.g., Grade 1)',
                border: OutlineInputBorder()
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _generateStudentQR,
               child: const Text('Generate Student QR'),
               ), 
               const SizedBox(height: 40),

               //Domain Name QR Code Section
              Text(
                'Generate Domain QR Code',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _domainNameController,
                decoration: const InputDecoration(
                  labelText: 'Domain Name (e.g., www.example.com)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generateDomainQR,
                 child: const Text('Generate Website QR'),
              ),
              const SizedBox(height: 40),

              //Displaying QRCode
              Center(
                child: QrImageView(data: _qrData,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  _qrData,
                  style: const TextStyle(
                    fontSize: 16
                  ),
                  textAlign: TextAlign.center,
                ),
              )
          ],
        ),
      ),
    );
  }
}