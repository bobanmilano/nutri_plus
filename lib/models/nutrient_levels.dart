import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'product.dart';
part 'nutrient_levels.g.dart';

@HiveType(typeId: 1)
class NutrientLevels {
  @HiveField(0)
  String? sugars;
  @HiveField(1)
  String? salt;
  @HiveField(2)
  String? fat;
  @HiveField(3)
  String? saturated_fat;

  NutrientLevels ({ this.sugars, this.salt, this.fat, this.saturated_fat });

  NutrientLevels.fromMappedJson(Map<String, dynamic> json) :
        this.sugars = json['sugars'] != null ? json['sugars'] : 'amount not specified',
        this.salt = json['salt'] != null ? json['salt'] : 'amount not specified',
        this.fat = json['fat'] != null ? json['fat'] : 'amount not specified',
        this.saturated_fat = json['saturated-fat'] != null ? json['saturated-fat'] : 'amount not specified';
}