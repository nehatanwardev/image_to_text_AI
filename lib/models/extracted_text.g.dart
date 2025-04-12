// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extracted_text.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExtractedTextAdapter extends TypeAdapter<ExtractedText> {
  @override
  final int typeId = 0;

  @override
  ExtractedText read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExtractedText(
      text: fields[0] as String,
      timestamp: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, ExtractedText obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.text)
      ..writeByte(1)
      ..write(obj.timestamp);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExtractedTextAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
