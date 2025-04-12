import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../models/extracted_text.dart';

class HomeController extends GetxController {
  final imageFile = Rx<File?>(null);
  final recognizedText = ''.obs;
  final isLoading = false.obs;
  final FlutterTts tts = FlutterTts();
  final Box<ExtractedText> historyBox = Hive.box<ExtractedText>('texts');

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      imageFile.value = File(picked.path);
      recognizeText(File(picked.path));
    }
  }

  Future<void> recognizeText(File image) async {
    isLoading.value = true;
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer();
    final RecognizedText result = await textRecognizer.processImage(inputImage);

    recognizedText.value = result.text;
    historyBox.add(ExtractedText(text: result.text, timestamp: DateTime.now()));
    isLoading.value = false;
  }

  Future<void> speakText() async {
    if (recognizedText.isNotEmpty) {
      await tts.setLanguage("en-US");
      await tts.setSpeechRate(0.5);
      await tts.speak(recognizedText.value);
    }
  }

  List<ExtractedText> get history =>
      historyBox.values.toList().reversed.toList();
}
