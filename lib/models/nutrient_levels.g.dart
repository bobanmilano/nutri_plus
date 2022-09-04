// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrient_levels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NutrientLevelsAdapter extends TypeAdapter<NutrientLevels> {
  @override
  final int typeId = 1;

  @override
  NutrientLevels read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return NutrientLevels(
      sugars: fields[0] as String?,
      salt: fields[1] as String?,
      fat: fields[2] as String?,
      saturated_fat: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, NutrientLevels obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.sugars)
      ..writeByte(1)
      ..write(obj.salt)
      ..writeByte(2)
      ..write(obj.fat)
      ..writeByte(3)
      ..write(obj.saturated_fat);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NutrientLevelsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
