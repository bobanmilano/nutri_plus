import 'package:flutter/cupertino.dart';
import "../lang/constants_de.dart" as DE;
import "../lang/constants_en.dart" as EN;
import "../lang/constants_it.dart" as IT;
import '../models/user_settings.dart';
import '../util/storage_manager.dart';

class Translator {

  static Map<String, String> translate = {};


  static void reloadLocalizations()  {
    UserSettings? userSettings = StorageManager.getUserSettings().getAt(0);
    switch(userSettings!.lang) {
      case "EN":
        translate = EN.locales;
        break;
      case "DE":
        translate = DE.locales;
        break;
      case "IT":
        translate = IT.locales;
        break;
    }
  }

  static setLanguage(int lang) async {
    UserSettings? userSettings = StorageManager.getUserSettings().getAt(0);

    switch(lang) {
      case 0:
        if (userSettings!.lang == "?.E") return;
        userSettings.lang = "DE";
        break;
      case 1:
        if (userSettings!.lang == "EN") return;
        userSettings.lang = "EN";
        break;
    }

    StorageManager.setUserSettings(userSettings!);
    Translator.reloadLocalizations();
    //StorageManager.loadAdditives();
  }

}