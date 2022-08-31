import 'package:flutter/material.dart';
import '../../models/food_category.dart';
import '../../models/product.dart';
import '../../lang/translator.dart';
import '../../widgets/conditional_container.dart';

class IngredientsAnalysis extends StatefulWidget {
  final Product product;
  const IngredientsAnalysis(this.product);

  @override
  _IngredientsAnalysisState createState() => _IngredientsAnalysisState();
}

class _IngredientsAnalysisState extends State<IngredientsAnalysis> {
  Product? _product;
  List<FoodCategory>? _foodCategory;

  void initState() {
    _product = widget.product;
    _foodCategory = <FoodCategory>[];
    _product!.ingredients_analysis_tags!.forEach((value) {
      _foodCategory!.add(new FoodCategory(value));
    });
    super.initState();
  }

  Widget foodCategory(int index) {
    return Container(
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),borderRadius:  BorderRadius.circular(12.0)),
        padding: const EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 3),
            Image(image: AssetImage(_foodCategory![index].getIcon(), ), height: 28),
            SizedBox(width: 8),
            Align(
              alignment: Alignment.centerLeft,
              child: FittedBox(
                  child: Text(_foodCategory![index].getLabel()!,
                maxLines: 2,
                softWrap: false,  overflow: TextOverflow.fade,
                style: TextStyle(color: Colors.black, fontSize: 12.0))
            )),
          ],
        )
    );
  }

  Widget _buildAnalysisButton(int index) {
    return Expanded(
        child: Card(
            color: _foodCategory![index].getColor()!,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            elevation: 3,
            shadowColor: Colors.white,
            child:foodCategory(index)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_foodCategory!.isEmpty) {
      return SizedBox(height: 0);
    } else {
      return ConditionalContainer(
          condition: _foodCategory!.isNotEmpty,
          child: Container(
              padding: const EdgeInsets.only(left: 4, right: 4),
              height: 42,
              child: Row(
                  children: _buildAnalysisButtons()
              )
          )
      );
    }
  }

  List<Widget> _buildAnalysisButtons() {
    List<Widget> buttons = [];
    int i = 0;
    _foodCategory!.forEach((element) {
      buttons.add(_buildAnalysisButton(i));
      i += 1;
    });
    return buttons;
  }
}
