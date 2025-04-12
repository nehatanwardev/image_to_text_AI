import 'package:hive/hive.dart';

part 'extracted_text.g.dart';

@HiveType(typeId: 0)
class ExtractedText {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime timestamp;

  ExtractedText({required this.text, required this.timestamp});
}
