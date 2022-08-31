import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'additive.g.dart';

@HiveType(typeId: 2)
class Additive extends HiveObject {

  @HiveField(0)
  String? Number;

  @HiveField(1)
  String? Category;

  @HiveField(2)
  String? Name;

  @HiveField(3)
  String? Comment;

  @HiveField(4)
  int? Toxicity; //1 - 4

  @HiveField(5)
  String? toxicityDescription;


  Additive({this.Number, this.Category, this.Name, this.Comment, this.Toxicity, this.toxicityDescription});


  String getShortName2() {
    return this.Category!.substring(0, this.Category!.length > 50 ? 50  : this.Category!.length)  + " ("
        + this.Name!.substring(0, this.Name!.length > 50 ? 50  : this.Name!.length) + ")";
  }

  String getCategory() {
    return this.Category!.substring(0, this.Category!.length > 20 ? 20  : this.Category!.length);
  }

  String getCleanNumber() {
    String clean = this.Number!.replaceAll(" ", "");
    clean = clean.substring(0, clean.length);
    return clean;
  }

}