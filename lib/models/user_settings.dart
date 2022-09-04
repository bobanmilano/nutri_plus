import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'user_settings.g.dart';

@HiveType(typeId: 3)
class UserSettings extends HiveObject {

  @HiveField(0)
  String? lang;

  UserSettings({this.lang});

  String getLanguage() {
    return this.lang!;
  }

}