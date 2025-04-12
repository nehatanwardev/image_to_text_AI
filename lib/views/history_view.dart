import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();

    return Scaffold(
      appBar: AppBar(title: const Text('History')),
      body: ListView.builder(
        itemCount: controller.history.length,
        itemBuilder: (context, index) {
          final item = controller.history[index];
          return ListTile(
            title: Text(item.text),
            subtitle: Text(item.timestamp.toLocal().toString()),
          );
        },
      ),
    );
  }
}
