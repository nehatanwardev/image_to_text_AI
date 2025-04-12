// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
// import 'package:flutter_tts/flutter_tts.dart';

// void main() {
//   runApp(const MaterialApp(home: ImageToTextScreen()));
// }

// class ImageToTextScreen extends StatefulWidget {
//   const ImageToTextScreen({Key? key}) : super(key: key);

//   @override
//   State<ImageToTextScreen> createState() => _ImageToTextScreenState();
// }

// class _ImageToTextScreenState extends State<ImageToTextScreen> {
//   File? _imageFile;
//   String _recognizedText = '';
//   final FlutterTts _flutterTts = FlutterTts();

//   Future<void> _pickImage(ImageSource source) async {
//     final pickedImage = await ImagePicker().pickImage(source: source);
//     if (pickedImage == null) return;

//     final imageFile = File(pickedImage.path);
//     setState(() => _imageFile = imageFile);

//     final inputImage = InputImage.fromFile(imageFile);
//     final textRecognizer = TextRecognizer();
//     final recognizedText = await textRecognizer.processImage(inputImage);

//     setState(() => _recognizedText = recognizedText.text);
//   }

//   Future<void> _speakText() async {
//     await _flutterTts.setLanguage("en-US");
//     await _flutterTts.setSpeechRate(0.5);
//     await _flutterTts.speak(_recognizedText);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text("Image to Text + TTS")),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               if (_imageFile != null) Image.file(_imageFile!, height: 200),
//               const SizedBox(height: 20),
//               Text(_recognizedText.isEmpty
//                   ? "No text detected."
//                   : _recognizedText),

//               const SizedBox(height: 20),
//               // const Spacer(),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.camera),
//                     icon: const Icon(Icons.camera),
//                     label: const Text("Camera"),
//                   ),
//                   ElevatedButton.icon(
//                     onPressed: () => _pickImage(ImageSource.gallery),
//                     icon: const Icon(Icons.photo),
//                     label: const Text("Gallery"),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               ElevatedButton.icon(
//                 onPressed: _recognizedText.isEmpty ? null : _speakText,
//                 icon: const Icon(Icons.volume_up),
//                 label: const Text("Speak"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'controllers/home_controller.dart';
import 'models/extracted_text.dart';
import 'views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(ExtractedTextAdapter());
  await Hive.openBox<ExtractedText>('texts');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Image to Text + TTS',
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
