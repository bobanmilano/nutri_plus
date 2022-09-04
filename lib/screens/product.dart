import 'package:flutter/material.dart';
import '../models/product_wrapper.dart';
import 'widgets/additives.dart';
import 'widgets/ingredients_analysis.dart';
import 'widgets/nutritiens.dart';
import 'widgets/ingredients.dart';
import '../widgets/conditional_container.dart';
import '../widgets/nova_group_widget.dart';
import '../widgets/nutri_score_widget.dart';
import 'history.dart';
import '../../util/constants.dart' as CONSTANTS;
import '../../util/helpers.dart';
import '../lang/translator.dart';

class ProductScreen extends StatefulWidget {
  final ProductWrapper? productWrapper;
  const ProductScreen({Key? key, this.productWrapper}) : super(key: key);

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  ProductWrapper? _productWrapper;

  void initState() {
    _productWrapper = widget.productWrapper;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        backgroundColor: Helpers.getNutriColor( _productWrapper!.product!.nutriscore_grade!),
        leading: IconButton(
          tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          icon: const Icon(Icons.arrow_back, color: Colors.white, size: 22),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child:
            Column(
              children: [
                  SizedBox(height: 3),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shadowColor: Colors.grey[600],
                          onPrimary: Colors.black,
                          onSurface: Colors.black,
                          primary: Colors.white, //background color of button
                          side: BorderSide(width:1, color:Colors.black12), //border width and color
                          elevation: 2, //elevation of button
                          shape: RoundedRectangleBorder( //to set border radius to button
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: EdgeInsets.all(1) //content padding inside button
                      ),
                      onPressed: () {  },
                      child: Text(_productWrapper!.product!.nutriscore_grade! != null ?
                    _productWrapper!.product!.nutriscore_grade!.toUpperCase() : CONSTANTS.QUESTION_MARK,
                          style: TextStyle( color: Colors.black, fontWeight: FontWeight.bold, fontSize: 28)),
                    )
              ],
            )
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.history, color: Colors.white, size: 22),
            tooltip: Translator.translate["PRODUCT_HISTORY"],
            onPressed: () {
              Navigator.push( context, MaterialPageRoute(builder: (context) => History()));
            },
          ),
        ]
      ),
      body: Container(
          color: Helpers.getNutriColor( _productWrapper!.product!.nutriscore_grade!),
          constraints: BoxConstraints.expand(),
        child:
          SingleChildScrollView(
          child: Container(
                    padding: EdgeInsets.all(5),
                   // height: MediaQuery. of(context).size.height,
                    color: Helpers.getNutriColor(_productWrapper!.product!.nutriscore_grade!),
                      child: Column(
                          children:
                              _buildProductWidgets()
                      )
                      )
          )
      )
    );
  }

  List<Widget> _buildProductWidgets() {
    List<Widget> widgets = [];
    widgets.add(_buildProductShorts());
    try {
      widgets.add(IngredientsAnalysis(_productWrapper!.product!));
    } catch(e) {

    }
    widgets.add(ConditionalContainer(
    condition: _productWrapper!.product!.allergens_tags!.length > 0 || _productWrapper!.product!.additives_tags!.length > 0,
    child: Additives(_productWrapper!.product!)
    ));
    widgets.add(Nutritions(_productWrapper!.product!));
    widgets.add(Ingredients(_productWrapper!.product!));

    return widgets;
  }

  Widget _buildProductShorts() {
    return Container(
      child:
        Card(
        child: Container(
        padding: const EdgeInsets.all(10),
        child: Row(
            children: [
              Expanded(
                flex: 6,
                child: Container(
                  child: Column(
                    children: [
                        Container(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Align(
                                    alignment: Alignment.center,
                                    child: Text(_productWrapper!.product!.product_name!,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 22,
                                              color: Colors.black87),
                                            overflow: TextOverflow.ellipsis, textAlign: TextAlign.left)
                                    )
                        ),
                        ConditionalContainer(
                            condition: _productWrapper!.product!.brands_tags! != CONSTANTS.EMPTY_STRING,
                            child: Center(
                                child: Text(_productWrapper!.product!.brands_tags!.join(", ").toUpperCase(),
                                  maxLines: 1,
                                    style: TextStyle( color: Colors.grey[700]),
                                    overflow: TextOverflow.ellipsis)
                            )
                        ),
                        SizedBox(height: 20),
                        Column(

                         children: <Widget>[
                            Container(
                            child: NutriScoreWidget(
                                score: _productWrapper! != null ? _productWrapper!.product!.nutriscore_grade! :
                                Translator.translate["SCORE_UNKNOWN"]!)
                            ),
                           SizedBox(height: 20),
                            Container(
                            child: NovaGroupWidget(
                                score: _productWrapper! != null && _productWrapper!.product!.nova_group! != null ?
                                _productWrapper!.product!.nova_group! : -1)
                            ),
                         ])
                  ],
                )
                ),
              ),
              SizedBox(width: 15),
              Expanded(
                flex: 3,
                  child: Container(
                    alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(left: 0),
                      child: _productWrapper!.product!.product_image != null ? Image(image: NetworkImage(
                                _productWrapper!.product!.product_image!),
                                fit: BoxFit.contain)
                          :
                      Image(image: AssetImage(CONSTANTS.PHOTO_COMING_SOON),
                          fit: BoxFit.contain),
                  )
              ),
            ])
    )
    ));
  }
}
