// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bankCard.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CardAdapter extends TypeAdapter<BankCard> {
  @override
  final int typeId = 3;

  @override
  BankCard read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BankCard(
      fields[0] as String,
      fields[1] as String,
      fields[2] as String,
      fields[3] as int,
      fields[4] as String,
      fields[5] as int,
      fields[6] as bool,
      fields[7] as String,
      fields[8] as String,
      fields[9] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, BankCard obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.shaba)
      ..writeByte(2)
      ..write(obj.number)
      ..writeByte(3)
      ..write(obj.password)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.color)
      ..writeByte(6)
      ..write(obj.numberVisibility)
      ..writeByte(7)
      ..write(obj.accountNumber)
      ..writeByte(8)
      ..write(obj.description)
      ..writeByte(9)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CardAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
