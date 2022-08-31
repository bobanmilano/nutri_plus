// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      product_name: fields[0] as String?,
      generic_name: fields[1] as String?,
      product_image: fields[16] as String?,
      brands_tags: (fields[18] as List?)?.cast<String>(),
      allergens_tags: (fields[19] as List?)?.cast<String>(),
      additives_tags: (fields[20] as List?)?.cast<String>(),
      nutriscore_grade: fields[22] as String?,
      nova_group: fields[23] as int?,
    )
      ..sugars_100g = fields[2] as double?
      ..sugars_unit = fields[3] as String?
      ..salt_100g = fields[4] as double?
      ..salt_unit = fields[5] as String?
      ..saturated_fat_100g = fields[6] as double?
      ..saturated_fat_unit = fields[7] as String?
      ..fat_100g = fields[8] as double?
      ..fat_unit = fields[9] as String?
      ..carbohydrates_100g = fields[10] as double?
      ..carbohydrates_unit = fields[11] as String?
      ..energy_kcal_100g = fields[12] as double?
      ..energy_kcal_unit = fields[13] as String?
      ..fiber_100g = fields[14] as double?
      ..fiber_unit = fields[15] as String?
      ..nutrientLevels = fields[24] as NutrientLevels?
      ..created_at = fields[25] as int?
      ..ingredients_text_de = fields[17] as String?
      ..ingredients_text_en = fields[26] as String?
      ..ingredients_analysis_tags = (fields[21] as List?)?.cast<String>();
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(27)
      ..writeByte(0)
      ..write(obj.product_name)
      ..writeByte(1)
      ..write(obj.generic_name)
      ..writeByte(2)
      ..write(obj.sugars_100g)
      ..writeByte(3)
      ..write(obj.sugars_unit)
      ..writeByte(4)
      ..write(obj.salt_100g)
      ..writeByte(5)
      ..write(obj.salt_unit)
      ..writeByte(6)
      ..write(obj.saturated_fat_100g)
      ..writeByte(7)
      ..write(obj.saturated_fat_unit)
      ..writeByte(8)
      ..write(obj.fat_100g)
      ..writeByte(9)
      ..write(obj.fat_unit)
      ..writeByte(10)
      ..write(obj.carbohydrates_100g)
      ..writeByte(11)
      ..write(obj.carbohydrates_unit)
      ..writeByte(12)
      ..write(obj.energy_kcal_100g)
      ..writeByte(13)
      ..write(obj.energy_kcal_unit)
      ..writeByte(14)
      ..write(obj.fiber_100g)
      ..writeByte(15)
      ..write(obj.fiber_unit)
      ..writeByte(16)
      ..write(obj.product_image)
      ..writeByte(24)
      ..write(obj.nutrientLevels)
      ..writeByte(25)
      ..write(obj.created_at)
      ..writeByte(17)
      ..write(obj.ingredients_text_de)
      ..writeByte(26)
      ..write(obj.ingredients_text_en)
      ..writeByte(18)
      ..write(obj.brands_tags)
      ..writeByte(19)
      ..write(obj.allergens_tags)
      ..writeByte(20)
      ..write(obj.additives_tags)
      ..writeByte(21)
      ..write(obj.ingredients_analysis_tags)
      ..writeByte(22)
      ..write(obj.nutriscore_grade)
      ..writeByte(23)
      ..write(obj.nova_group);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
