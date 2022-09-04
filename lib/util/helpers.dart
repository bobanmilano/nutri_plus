import 'package:flutter/material.dart';
import 'package:nutri_plus/util/storage_manager.dart';
import '../models/user_settings.dart';
import 'constants.dart' as CONSTANTS;


class Helpers {

  static getNutriColor(String val) {
    switch(val) {
      case CONSTANTS.a:
        return Colors.green[800];
        break;
      case CONSTANTS.b:
        return Colors.green[300];
        break;
      case CONSTANTS.c:
        return Colors.yellow[600];
        break;
      case CONSTANTS.d:
        return Colors.orange[500];
        break;
      case CONSTANTS.e:
        return Colors.red[500];
        break;
      default:
        return Colors.grey[400];
    }
  }

  static AssetImage getNutriImage(String grade) {
    return grade == null || grade == "" ? AssetImage("assets/images/nutriscore-not-available.png")
        : AssetImage("assets/images/nutri-score-" + grade + ".png");
  }

  static AssetImage getNovaImage(String group) {
    return group == null || group == "" ? AssetImage("assets/images/nova-unknown.png")
        : AssetImage("assets/images/novagroup-" + group + ".jpg");
  }

  static String? getLanguage()  {
    UserSettings? userSettings = StorageManager.getUserSettings().getAt(0);
    return userSettings!.lang;
  }

}