import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:nutri_plus/lang/translator.dart';
import 'package:nutri_plus/util/helpers.dart';
import 'nutrient_levels.dart';
import '../lang/translator.dart';
part 'product.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  //name e.g. "Nutella & Go!"
  @HiveField(0)
  String? product_name;
  @HiveField(1)
  String? generic_name;
  @HiveField(2)
  double? sugars_100g;
  @HiveField(3)
  String? sugars_unit;
  @HiveField(4)
  double? salt_100g;
  @HiveField(5)
  String? salt_unit;
  @HiveField(6)
  double? saturated_fat_100g;
  @HiveField(7)
  String? saturated_fat_unit;
  @HiveField(8)
  double? fat_100g;
  @HiveField(9)
  String? fat_unit;
  @HiveField(10)
  double? carbohydrates_100g;
  @HiveField(11)
  String? carbohydrates_unit;
  @HiveField(12)
  double? energy_kcal_100g;
  @HiveField(13)
  String? energy_kcal_unit;
  @HiveField(14)
  double? fiber_100g;
  @HiveField(15)
  String? fiber_unit;
  @HiveField(16)
  String? product_image;
  @HiveField(24)
  NutrientLevels? nutrientLevels;
  @HiveField(25)
  int? created_at;

  @HiveField(17)
  String? ingredients_text_de;

  @HiveField(26)
  String? ingredients_text_en;

  //brand(s) e.g. Nutella, Ferrero
  @HiveField(18)
  List<String>? brands_tags;

  //allergens e.g. gluten, milk, nuts ...
  @HiveField(19)
  List<String>? allergens_tags;

  //additives e.g. E322, E322i, ...
  @HiveField(20)
  List<String>? additives_tags;
  @HiveField(21)
  List<String>? ingredients_analysis_tags;

  //official nutriscrore from A(best) to E(worst)
  @HiveField(22)
  String? nutriscore_grade;

  //level of processing. 1 = non/minimal processed -> 4 = ultra processed
  @HiveField(23)
  int? nova_group;

  Product({ this.product_name, this.generic_name, this.product_image, this.brands_tags, this.allergens_tags,
    this.additives_tags, this.nutriscore_grade, this.nova_group });

  Product.fromMappedJson(Map<String, dynamic> json) :
        this.product_name = json['product_name'] != "" ? json['product_name'] : 'name not found',
        this.generic_name = json['generic_name_de'] != null ? json['generic_name_de'] : '',
        this.sugars_100g = json['nutriments']['sugars_100g'] != 0 ? json['nutriments']['sugars_100g'].toDouble() : -1,
        this.sugars_unit = json['nutriments']['sugars_unit'] != null ? json['nutriments']['sugars_unit'] : 'g',
        this.salt_100g = json['nutriments']['salt_100g'] != null ? json['nutriments']['salt_100g'].toDouble() : -1,
        this.salt_unit = json['nutriments']['salt_unit'] != null ? json['nutriments']['salt_unit'] : 'g',
        this.fiber_100g = json['nutriments']['fiber_100g'] != null ? json['nutriments']['fiber_100g'].toDouble() : -1,
        this.fiber_unit = json['nutriments']['fiber_unit'] != null ? json['nutriments']['fiber_unit'] : 'g',
        this.fat_100g = json['nutriments']['fat_100g'] != null ? json['nutriments']['fat_100g'].toDouble() : -1,
        this.fat_unit = json['nutriments']['fat_unit'] != null ? json['nutriments']['fat_unit'] : 'g',
        this.ingredients_text_de = json['ingredients_text_de'] != "" && json['ingredients_text_de'] != null ? json['ingredients_text_de'] : "",
        this.ingredients_text_en = json['ingredients_text_en'] != "" && json['ingredients_text_en'] != null ? json['ingredients_text_en'] : "",
        this.saturated_fat_100g = json['nutriments']['saturated-fat_100g'] != null ? json['nutriments']['saturated-fat_100g'].toDouble() : -1,
        this.saturated_fat_unit = json['nutriments']['saturated-fat_unit'] != null ? json['nutriments']['saturated-fat_unit'] : 'g',
        this.carbohydrates_100g = json['nutriments']['carbohydrates_100g'] != null ? json['nutriments']['carbohydrates_100g'].toDouble()  : -1,
        this.carbohydrates_unit = json['nutriments']['carbohydrates_unit'] != null ? json['nutriments']['carbohydrates_unit'] : 'g',
        this.energy_kcal_100g = json['nutriments']['energy-kcal_100g'] != null ? json['nutriments']['energy-kcal_100g'].toDouble()  : -1,
        this.energy_kcal_unit = json['nutriments']['energy-kcal_unit'] != null ? json['nutriments']['energy-kcal_unit'] : '',
        this.product_image = json['image_front_small_url'] != "" ? json['image_front_small_url'] : null,
        this.nutriscore_grade = json['nutriscore_grade'] != 0 ? json['nutriscore_grade'] : 'x',
        this.nova_group = json['nova_group'] != null ? json['nova_group'] : -1,
        this.brands_tags = json['brands_tags'] != null ? json['brands_tags'].cast<String>() : [],
        this.allergens_tags = json['allergens_tags'] != null ? json['allergens_tags'].cast<String>() : [],
        this.additives_tags = json['additives_tags'] != null ? json['additives_tags'].cast<String>() : [],
        this.ingredients_analysis_tags = json['ingredients_analysis_tags'] != null ? json['ingredients_analysis_tags'].cast<String>() : [],
        this.created_at = DateTime.now().microsecondsSinceEpoch,
        this.nutrientLevels = NutrientLevels.fromMappedJson(json["nutrient_levels"]);


  String? getIngredientsList() {
    if(Helpers.getLanguage() == "DE")
      return this.ingredients_text_de;

    return this.ingredients_text_en;
  }

}