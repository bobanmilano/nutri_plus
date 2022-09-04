import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../lang/translator.dart';
import '../../util/helpers.dart';
import '../../widgets/conditional_container.dart';

class Ingredients extends StatefulWidget {
  final Product product;

  const Ingredients(this.product);

  @override
  _IngredientsState createState() => _IngredientsState();
}

class _IngredientsState extends State<Ingredients> {
  Product? _product;

  void initState() {
    this._product = widget.product;
    super.initState();
  }

  bool _showIngredients() {
    if(Helpers.getLanguage() == "DE") {
      if(_product!.ingredients_text_de != null && _product!.ingredients_text_de!.isNotEmpty)
          return true;
    }
    if(Helpers.getLanguage() == "EN") {
      if(_product!.ingredients_text_en != null && _product!.ingredients_text_en!.isNotEmpty)
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return
            Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  ConditionalContainer(
                      condition: _showIngredients() == true,
                      child:
                      Card(
                          child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                    color: Colors.grey[200],
                                    padding: const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
                                    child:
                                    Row(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Icon(Icons.menu_book, color: Colors.grey[800], size: 20),
                                          SizedBox(width: 10),
                                          Expanded(
                                              child:
                                              Container(
                                                  child: Text(Translator.translate["INGREDIENTS_LIST"]!,
                                                      textAlign: TextAlign.left,
                                                      style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16)),
                                              ))
                                        ])),
                                  Container(
                                        padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 15),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [

                                                SizedBox(height: 10),
                                                Text(_product!.getIngredientsList()!, textAlign: TextAlign.left),
                                              ],
                                            )
                                        )
                          ]),
                      )
                  )
                ]
          );
  }
}
