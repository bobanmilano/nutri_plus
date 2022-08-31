// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'additive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AdditiveAdapter extends TypeAdapter<Additive> {
  @override
  final int typeId = 2;

  @override
  Additive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Additive(
      Number: fields[0] as String?,
      Category: fields[1] as String?,
      Name: fields[2] as String?,
      Comment: fields[3] as String?,
      Toxicity: fields[4] as int?,
      toxicityDescription: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Additive obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.Number)
      ..writeByte(1)
      ..write(obj.Category)
      ..writeByte(2)
      ..write(obj.Name)
      ..writeByte(3)
      ..write(obj.Comment)
      ..writeByte(4)
      ..write(obj.Toxicity)
      ..writeByte(5)
      ..write(obj.toxicityDescription);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdditiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
