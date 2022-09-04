import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nutri_plus/screens/scan.dart';
import 'util/storage_manager.dart';
import 'package:hive/hive.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _initStorage();

  runApp(MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NutriPlusApp(),
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init()
  ));

  configLoading();
}

_initStorage() async {
  await Hive.initFlutter();
  //await Hive.deleteFromDisk();
  await StorageManager.registerAdapters();
  await StorageManager.initBoxes();
  await StorageManager.loadSettings();
  await StorageManager.loadAdditives();

  return;
}

void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

class NutriPlusApp extends StatefulWidget {
  @override
  _NutriPlusAppState createState() => _NutriPlusAppState();
}


class _NutriPlusAppState extends State<NutriPlusApp> {
  @override
  Widget build(BuildContext context) {
    return ScanPage();
  }

  void dispose() {
    StorageManager.closeBoxes();
    super.dispose();
  }

}
