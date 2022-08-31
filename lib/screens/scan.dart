import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:nutri_plus/screens/product.dart';
import '../models/product_wrapper.dart';
import '../services/open_food_facts_service.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../lang/translator.dart';
import "../util/constants.dart" as CONSTANTS;
import '../util/storage_manager.dart';
import 'history.dart';

class ScanPage extends StatefulWidget {
  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? qrCodeResult = "";
  Timer? _timer;
  ProductWrapper? product;
  var appBarHeight = AppBar().preferredSize.height;

  Future<String> getBarcode() async {
    String code = "5020411121182"; //nutella
    code = "4001686301555"; //haribo
    code = "8076809523776"; //fetucine
    code = "9000295803530"; //felix gurken
    code = "4001686301555"; //haribo
    code = "9002490100070"; //red bull
    code = "5020411121182"; //nutella
    code = "4890008100309"; //coca cola
    code = "9000332812822"; //casali schokobananen
    code = "9000331697048"; //manner

    code = "9000332812822"; //casali schokobananen
    code = "7622210635396"; //milka brownies
    code = "9002490205973"; //red bull
    //code = "87108026"; //mentos fruit// await BarcodeScanner.scan();
    return code;
  }

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context)  {
    return Scaffold(
      appBar: AppBar(
        leading:
        IconButton(
          icon: const Icon(Icons.history, color: Colors.white, size: 22),
          tooltip: "history",
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => History()));
          },
        ),
        title: Text("NutriPlus"),
        centerTitle: true,
        elevation: 0,
        actions: <Widget>[

          PopupMenuButton(
            icon: Icon(Icons.language),
            onSelected: (int newValue) async { // add this property
              await Translator.setLanguage(newValue);
              setState(() {});
              Fluttertoast.showToast(msg: Translator.translate["LANG_SWITCHED"]!,   backgroundColor: Colors.blueGrey[400]);
            },
            offset: Offset(0.0, appBarHeight),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            itemBuilder: (context) => [
              PopupMenuItem(
                child: Text("Deutsch"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text("English"),
                value: 1,
              ),
            ],
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.green,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
                  child: Text(
                    Translator.translate["TAP_TO_SCAN"]!,
                    style: TextStyle(color:Colors.white, fontSize:20, fontWeight:FontWeight.bold),
                  ),
            ),
            SizedBox(height: 50),
            Center(
              child: MaterialButton(
                onPressed: () async {
                  try {
                    _timer?.cancel();
                    String code = await getBarcode();

                    await EasyLoading.show(
                      status: "processing ...",
                      maskType: EasyLoadingMaskType.black,
                    );

                    setState(() {
                      qrCodeResult = code;
                    });

                    if(qrCodeResult != CONSTANTS.EMPTY_STRING) {
                      await OpenFoodFactsService(qrCodeResult).fetchApi().then((value) => {
                        if (value != null) {
                          setState(() {
                            product = value;
                          }),
                          StorageManager.addProduct(product!.product!),
                          Navigator.push( context, MaterialPageRoute(builder:
                              (context) => ProductScreen(productWrapper: product)))
                        } else {
                          Fluttertoast.showToast(msg: Translator.translate["SCAN_ERROR"]!)
                        }
                      });
                    }

                  } catch(e) {

                  }
                  await EasyLoading.dismiss();
                },
                color: Colors.green[300],
                padding: EdgeInsets.all(35),
                textColor: Colors.white,
                shape: CircleBorder(),
                child: Icon(
                  Icons.qr_code_scanner,
                  size: 104,
                ),
              ),
            )
            //Text("Additives: " + StorageManager.getAdditives().length.toString())
          ],
        ),
      ),
    );
  }

}
