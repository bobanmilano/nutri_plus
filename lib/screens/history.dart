import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../lang/translator.dart';
import '../models/product.dart';
import 'widgets/additives.dart';
import 'widgets/ingredients.dart';
import 'widgets/ingredients_analysis.dart';
import 'widgets/nutritiens.dart';
import '../util/helpers.dart';
import '../util/storage_manager.dart';
import '../widgets/conditional_container.dart';
import 'scan.dart';
import '../util/constants.dart' as CONSTANTS;

class History extends StatefulWidget {
  const History();

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          elevation: 0,
          leading: IconButton(
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
            icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
            title: Text(Translator.translate["HISTORY_PAGE"]!),
            centerTitle: true,
            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.home, color: Colors.white, size: 22),
                onPressed: () {
                  Navigator.push( context, MaterialPageRoute(builder: (context) => ScanPage()));
                },
              ),
              IconButton(
                          icon: const Icon(Icons.delete, color: Colors.white, size: 22),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(Translator.translate["DELETE"]!),
                                  content: Text(Translator.translate["DELETE_HISTORY"]!),
                                  actions: <Widget>[
                                    TextButton(
                                        onPressed: () => _deleteHistory(),

                                        child: Text(Translator.translate["YES"]!)
                                    ),
                                    TextButton(
                                      onPressed: () => Navigator.of(context).pop(false),
                                      child: Text(Translator.translate["NO"]!),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        )
            ]
        ),
        body:
    Container(
        padding: EdgeInsets.only(left: 15.0, top: 0.0, right: 15.0, bottom: 15.0),
        color: Colors.green,
        child: Column(
            children:[
              Expanded(
                  child:
                      ValueListenableBuilder<Box<Product>>(
                          valueListenable: StorageManager.getHistory().listenable(),
                          builder: (context, box, _) {
                            final products = box.values.toList().cast<Product>().reversed.toList();
                            return buildContent(products);
                          }
                      )
                      )
                ]
        )
    )
    );
  }

  void _deleteHistory() async {
    StorageManager.deleteHistory();
    Navigator.of(context).pop(true);
  }

  Widget buildContent(List<Product> products) {
    if (products.isEmpty) {
      return Center(
        child: Text(
          Translator.translate["HISTORY_EMPTY"]!,
          style: TextStyle(fontSize: 18),
        ),
      );
    } else {
      return Column(
        children: [
          SizedBox(height: 5),
          ConditionalContainer(
            condition: StorageManager.getHistory().length > 150,
            child: Card(
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: Text(Translator.translate["HISTORY_FULL"]!,
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 14),
                )
              )
            )
          ),
          Expanded(
            child:
            ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (BuildContext context, int index) {
                  var product = products[index];
                  return Dismissible(

                    key: Key(product.created_at.toString()),
                      confirmDismiss: (DismissDirection direction) async {
                        return await showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(Translator.translate["DELETE"]!),
                              content: Text(product.product_name!.toUpperCase() + Translator.translate["DELETE_PRODUCT"]!),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () => Navigator.of(context).pop(true),
                                    child: Text(Translator.translate["YES"]!)
                                ),
                                TextButton(
                                  onPressed: () => Navigator.of(context).pop(false),
                                  child: Text(Translator.translate["NO"]!),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    onDismissed: (direction) {
                      // Remove the item from the data source.
                      setState(() {
                        StorageManager.deleteProduct(StorageManager.getHistory(), product.created_at!);
                        products.removeAt(index);
                      });
                      ScaffoldMessenger.of(context)
                          .showSnackBar(SnackBar(
                              backgroundColor: Colors.green[800],
                              content: Text(product.product_name!.toUpperCase() + Translator.translate["HAS_BEEN_DELETED"]!)));
                    },
                    child:
                        _buildProduct(context, product, index)
                  );
              }
            ),
          ),
        ],
      );
    }
  }

  Widget _buildProduct( BuildContext context, Product product, int index) {
    return Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Helpers.getNutriColor(product.nutriscore_grade!), width: 5),
          borderRadius: BorderRadius.circular(10),
        ),
      child: ExpansionTile(
        collapsedBackgroundColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        tilePadding: EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        title: Row(
          children: [
            product.product_image != null ? Image(image: NetworkImage(
                product.product_image!),
                fit: BoxFit.contain, height: 80, width: 60) :
            Image(image: AssetImage(CONSTANTS.PHOTO_COMING_SOON),    fit: BoxFit.contain, height: 80, width: 60),
            SizedBox(width: 10),
            Flexible(
                child: Column(
                  children: [
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(product.product_name! != "" || product.product_name! != null ?
                        product.product_name! : product.generic_name!,
                          maxLines: 2,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.black87),
                        )),
                    SizedBox(height: 15),
                    ConditionalContainer(
                      condition: product.brands_tags!.length > 0,
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(product.brands_tags!.join(", ").toUpperCase(),
                              maxLines: 1,
                              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 11),
                            ))
                    )
                  ],
                )
            )
          ],
        ),
        trailing:
        Image(image: Helpers.getNutriImage(product.nutriscore_grade!),
            fit: BoxFit.contain),

          children: <Widget>[
          ListTile(
            tileColor:  Helpers.getNutriColor(product.nutriscore_grade!),
            minVerticalPadding: 0,
            contentPadding: EdgeInsets.all(0),
            title:
                  Container(
                  color: Helpers.getNutriColor(product.nutriscore_grade!),
                    child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Column(
                            children: [
                              IngredientsAnalysis(product),
                              ConditionalContainer(
                                  condition: product.allergens_tags!.length > 0 || product.additives_tags!.length > 0,
                                  child: Additives(product)
                              ),
                              Nutritions(product),
                              Ingredients(product)
                            ]
                        )
                    )
                )
                ),
            ]
          )
    );
  }
}
