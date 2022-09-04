import 'package:flutter/material.dart';
import '../lang/translator.dart';

class FoodCategory {

  String? type;

  String? label;

  FoodCategory(String foodType) {
    this.type = foodType.replaceAll("en:", "");
    this.label = foodType.replaceAll("en:", "");
  }

  String? getLabel() {
    switch(this.label) {
      case "vegan":
        return this.label!;
        break;

      case "vegetarian":
        return Translator.translate["vegetarian"];
        break;

      case "palm-oil-free":
        return Translator.translate["palm-oil-free"];
        break;

      case "non-vegan":
        return Translator.translate["non-vegan"];
        break;

      case "non-vegetarian":
        return Translator.translate["non-vegetarian"];
        break;

      case "palm-oil":
        return Translator.translate["palm-oil"];
        break;

      case "may-contain-palm-oil":
        return Translator.translate["may-contain-palm-oil"];
        break;

      case "maybe-vegetarian":
        return Translator.translate["maybe-vegetarian"];
        break;

      case "maybe-vegan":
        return Translator.translate["maybe-vegan"];
        break;

      case "palm-oil-content-unknown":
        return Translator.translate["palm-oil-content-unknown"];
        break;

      case "vegan-status-unknown":
        return Translator.translate["vegan-status-unknown"];
        break;

      case "vegetarian-status-unknown":
        return Translator.translate["vegetarian-status-unknown"];
        break;

      default:
        return "";
        break;
    }
  }

  Color? getColor() {
    switch(this.type) {
      case "vegan":
      case "vegetarian":
      case "palm-oil-free":
        return Colors.green[300];
        break;

      case "non-vegan":
      case "non-vegetarian":
      case "palm-oil":
        return Colors.red[300];
        break;

      default:
        return Colors.grey[300];
        break;

    }
  }

  String getIcon() {
    switch(this.label) {
      case "palm-oil-free":
      case "palm-oil":
      case "may-contain-palm-oil":
      case "palm-oil-content-unknown":
        return "assets/images/palm-oil.png";
        break;

      case "vegetarian":
      case "non-vegetarian":
      case "maybe-vegetarian":
      case "vegetarian-status-unknown":
        return "assets/images/veggie.png";
        break;

      default:
        return "assets/images/vegan.png";
        break;
    }
  }

}