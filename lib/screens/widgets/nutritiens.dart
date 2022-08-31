import 'package:flutter/material.dart';
import '../../models/product.dart';
import '../../lang/translator.dart';
import '../../widgets/colored_indicator.dart';
import '../../util/constants.dart' as CONSTANTS;

class Nutritions extends StatefulWidget {
  final Product? product;

  const Nutritions(this.product);

  @override
  _NutritionsState createState() => _NutritionsState();
}

class _NutritionsState extends State<Nutritions> {
  Product? _product;

  void initState() {
    this._product = widget.product;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                  color: Colors.grey[200],
                  padding: const EdgeInsets.only(left: 13, top: 10, right: 10, bottom: 10),
                  child:
                  Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Icon(Icons.bar_chart, color: Colors.grey[800], size: 22),
                        SizedBox(width: 10),
                        Expanded(
                            child:
                            Container(
                                child: Text(Translator.translate["NUTRIENTS_100G"]!,
                                    textAlign: TextAlign.left,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16))))
                      ])),
              Container(
            padding: const EdgeInsets.only(left: 15, top: 0, right: 10, bottom: 10),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[

                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        ColoredIndicator(level: _product!.nutrientLevels!.sugars!
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["SUGAR"]! + (_product!.sugars_100g! > 0 ? _product!.sugars_100g!.toStringAsFixed(1)
                            + _product!.sugars_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14) )
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["CARBOHYDRATES"]! + (_product!.carbohydrates_100g! > 0 ?
                        _product!.carbohydrates_100g!.toStringAsFixed(1) + _product!.carbohydrates_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14)),
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        ColoredIndicator(level: _product!.nutrientLevels!.saturated_fat!
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["SATURATED_FAT"]! + (_product!.saturated_fat_100g! > 0 ?
                        _product!.saturated_fat_100g!.toStringAsFixed(1) + _product!.saturated_fat_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14))
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["CALORIES"]! + (_product!.energy_kcal_100g! > 0 ?
                        _product!.energy_kcal_100g!.toStringAsFixed(1)  +  _product!.energy_kcal_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14))
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        ColoredIndicator(level: _product!.nutrientLevels!.salt!
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["SALT"]! + (_product!.salt_100g! > 0 ? _product!.salt_100g!.toStringAsFixed(1)
                            + _product!.salt_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14))
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        ColoredIndicator(level: _product!.nutrientLevels!.fat!
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["FAT"]! + (_product!.fat_100g! > 0 ? _product!.fat_100g!.toStringAsFixed(1)
                            + _product!.fat_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14))
                      ]
                  ),
                  SizedBox(height: 20),
                  Row(
                      children: <Widget> [
                        Icon(
                          Icons.info_outline_rounded,
                          color: Colors.grey,
                          size: 24.0,
                        ),
                        SizedBox(width: 12),
                        Text(Translator.translate["FIBER"]! + (_product!.fiber_100g! > 0 ? _product!.fiber_100g!.toStringAsFixed(1)
                            + _product!.fiber_unit! : CONSTANTS.ZERO), style: const TextStyle(fontSize: 14))
                      ]
                  )
                ]
            )
        )]));
  }
}
