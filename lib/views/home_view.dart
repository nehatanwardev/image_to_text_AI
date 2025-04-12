import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/home_controller.dart';
import 'history_view.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image to Text + TTS'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Get.to(() => const HistoryView()),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => Column(
            children: [
              controller.imageFile.value != null
                  ? Image.file(
                      controller.imageFile.value!,
                      height: 200,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(fallbackHeight: 200),
              const SizedBox(height: 20),
              controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          controller.recognizedText.value.isEmpty
                              ? 'No text detected.'
                              : controller.recognizedText.value,
                          style: const TextStyle(
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: controller.recognizedText.value.isEmpty
                    ? null
                    : () {
                        Clipboard.setData(
                          ClipboardData(text: controller.recognizedText.value),
                        );
                        // Get.snackbar(
                        //   'Copied',
                        //   'Text copied to clipboard!',
                        //   snackPosition: SnackPosition.BOTTOM,
                        // );
                      },
                icon: const Icon(Icons.copy),
                label: const Text('Copy Text'),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => controller.pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => controller.pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: controller.recognizedText.value.isEmpty
                    ? null
                    : () => controller.speakText(),
                icon: const Icon(Icons.volume_up),
                label: const Text('Speak'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
