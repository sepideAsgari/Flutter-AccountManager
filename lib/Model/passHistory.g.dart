// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'passHistory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PassHistoryAdapter extends TypeAdapter<PassHistory> {
  @override
  final int typeId = 1;

  @override
  PassHistory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PassHistory(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, PassHistory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.password)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PassHistoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
