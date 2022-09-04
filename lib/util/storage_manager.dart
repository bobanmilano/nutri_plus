import 'dart:convert';
import 'package:hive/hive.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;
import '../lang/translator.dart';
import '../models/additive.dart';
import '../models/product.dart';
import '../models/nutrient_levels.dart';
import '../models/user_settings.dart';
import '../util/constants.dart' as CONSTANTS;

class StorageManager {

  static final int _maxEntriesHistory = 4;

  static Box<Product> getHistory() => Hive.box<Product>(CONSTANTS.BOX_HISTORY);
  static Box<Additive> getAdditives() => Hive.box<Additive>(CONSTANTS.BOX_ADDITIVES);
  static Box<UserSettings> getUserSettings() => Hive.box<UserSettings>(CONSTANTS.BOX_SETTINGS);

  static initBoxes() async {
    await Hive.openBox<Additive>(CONSTANTS.BOX_ADDITIVES);
    await Hive.openBox<Product>(CONSTANTS.BOX_HISTORY);
    await Hive.openBox<UserSettings>(CONSTANTS.BOX_SETTINGS);
  }

  static closeBoxes() async {
    await Hive.box(CONSTANTS.BOX_HISTORY).close();
    await Hive.box(CONSTANTS.BOX_ADDITIVES).close();
    await Hive.box(CONSTANTS.BOX_SETTINGS).close();
  }

  static registerAdapters() async {
    Hive.registerAdapter(ProductAdapter());
    Hive.registerAdapter(NutrientLevelsAdapter());
    Hive.registerAdapter(AdditiveAdapter());
    Hive.registerAdapter(UserSettingsAdapter());
  }

  static loadAdditives() async {
    await Hive.deleteBoxFromDisk(CONSTANTS.BOX_ADDITIVES);
    await Hive.openBox<Additive>(CONSTANTS.BOX_ADDITIVES);

    Box<Additive>? additives = Hive.box<Additive>(CONSTANTS.BOX_ADDITIVES);
    ByteData data;

    if(getUserSettings().getAt(0)!.lang == "DE")
      data = await rootBundle.load("assets/files/e-numbers_de.xlsx");
    else
      data = await rootBundle.load("assets/files/e-numbers_en.xlsx");

    var bytes = data.buffer.asUint8List(
        data.offsetInBytes, data.lengthInBytes);

    var excel = Excel.decodeBytes(bytes);
    Additive? add;
    //int i = 0;
    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        if (row != null && row[0] != null && row[0] != '') {
          add = getAdditive(row);
          additives.add(add!);
        }
      }
    }
  }

  static getAdditive(var row) {
    return Additive(Number: row[0] != null ? row[0].value.toString().toLowerCase().trim() : '',
        Category: row[1] != null ? row[1].value.toString().trim() : '',
        Name: row[2] != null ? row[2].value.toString().trim() : '',
        Comment: row[3] != null ? row[3].value.toString().trim() : '',
        Toxicity: row[4] != null ?  row[4].value : -1,
        toxicityDescription: row[5] != null ? row[5].value.toString().trim() : '');
  }

  static loadSettings() async {
    if(getUserSettings().isEmpty) {
      UserSettings userSettings = UserSettings();
      userSettings.lang = "EN";
      setUserSettings(userSettings);
    }
    Translator.reloadLocalizations();
  }

  static UserSettings setUserSettings(UserSettings userSettings) {
    Box<UserSettings> box = Hive.box<UserSettings>(CONSTANTS.BOX_SETTINGS);
    if(box.isNotEmpty) {
      box.putAt(0, userSettings);
    } else {
      box.add(userSettings);
    }

    return userSettings;
  }

  static addProduct(Product product)
  {
    if (getHistory().length < 150) {
      getHistory().add(product);
    }
  }

  static bool historyIsFull() {
    if(getHistory().length > _maxEntriesHistory) return true;
    return false;
  }

  static int getMaxEntries() {
    return _maxEntriesHistory;
  }

  static deleteHistory() async {
    await getHistory().clear();
  }

  static deleteProduct(Box<Product> box, int id) {
    final Map<dynamic, Product> productsMap = box.toMap();
    dynamic keyToDelete = -1;
    productsMap.forEach((key, value){
      if (value.created_at == id)
        keyToDelete = key;
    });
    if(keyToDelete != -1)
      box.delete(keyToDelete);
  }


}