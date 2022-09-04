import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../../lang/translator.dart';
import '../../models/additive.dart';
import '../../models/product.dart';
import '../../util/helpers.dart';
import '../../util/storage_manager.dart';
import '../../widgets/conditional_container.dart';
import '../../util/constants.dart' as CONSTANTS;

class Additives extends StatefulWidget {
  final Product product;
  const Additives(this.product);
  @override
  _AdditivesState createState() => _AdditivesState();
}

class _AdditivesState extends State<Additives> {
  List<String>? _additives;
  List<String>? _allergenes;
  Product? _product;
  Box<Additive>? additives;
  UniqueKey? keyTile;
  Map<String, String>? allergenes;

  void initState() {
    this._product = widget.product;
    this._additives = _product!.additives_tags;
    this._allergenes = _product!.allergens_tags;
    additives = StorageManager.getAdditives();
    allergenes = {
      "mustard" : "Senf",
      "nuts" : "Schalenfrüchte",
      "hazelnuts":"Haselnüsse",
      "milk": "Milch",
      "gluten": "Gluten",
      "soy": "Soja",
      "soya": "Soja",
      "soybeans": "Sojabohnen",
      "egg": "Eier",
      "eggs": "Eier",
      "sesame": "Sesam",
      "sesame-seeds": "Sesam",
      "wheat": "Weizen",
      "oats": "Haferflocken",
      "garlic": "Knoblauch"
    };
    super.initState();
  }

  Additive? _getAdditiveModel(String code) {
    Additive? add;
    String codeOpt = code.replaceAll("en:", "");
    try {
      add = additives!.values.where((Additive) =>
      Additive.Number!.replaceAll(' ', '') == codeOpt).first;
      return add;
    } catch(e) {
      print(e);
    }

    return null;
  }

  Icon _getAdditiveIcon(String code) {
    Additive? add = _getAdditiveModel(code);
    int level = add != null ? add.Toxicity! : -1;
    switch(level) {
      case 1:
        return Icon(Icons.science_outlined, color: Colors.grey, size: 18);
        break;
      case 2:
        return Icon(Icons.report_problem, color: Colors.yellow[700], size: 18);
        break;
      case 3:
        return Icon(Icons.report_problem, color: Colors.orange[700], size: 18);
        break;
      case 4:
        return Icon(Icons.report_problem, color: Colors.red[700], size: 18);
        break;
      default:
        return Icon(Icons.science_outlined, color: Colors.grey, size: 18);
        break;
    }
  }

  Color _getToxicityColor(String code) {
    Additive? add = _getAdditiveModel(code);
    int level = add != null ? add.Toxicity! : -1;
    switch(level) {
      case 1:
        return Colors.black;
        break;
      case 2:
        return  Colors.yellow[700]!;
        break;
      case 3:
        return Colors.orange[700]!;
        break;
      case 4:
        return Colors.red[700]!;
        break;
      default:
        return Colors.black;
        break;
    }
  }

  String _getDescription(String number) {
    Additive? add = _getAdditiveModel(number);
    if (add != null) return add.Comment!;
    return "";
  }

  String _getHealthRisks(String code) {
    Additive? add = _getAdditiveModel(code);
    if (add != null) return add.toxicityDescription!;
    return "";
  }

  String _getName(String code) {
    Additive? add = _getAdditiveModel(code);
    if (add != null) return add.Name!;

    return " ";
  }

  String _getCategory(String code) {
    Additive? add = _getAdditiveModel(code);
    if(add != null) return add.Category!;

    return "";
  }

  String getAllergenes() {
    List<String> result =[];
    String allergene = "";
    String res;
    for(var i = 0; i < _allergenes!.length; i++) {
      allergene = _allergenes![i].replaceAll("en:", "");
      if(allergene != "" && allergene != null) {
        res = Translator.translate[allergene]!;
        result.add(res);
      }else {
        result.add(_allergenes![i].replaceAll("en:", ""));
      }
    }
    return result.join(", ").toString();
  }

  @override
  Widget build(BuildContext context) {
    return
            Column (
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>
                [
                  ConditionalContainer(
                      condition: _additives!.isNotEmpty,
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
                                    Icon(Icons.science, color: Colors.grey[800], size: 22),
                                    SizedBox(width: 10),
                                    Expanded(
                                      child:
                                    Container(
                                        child: Text(Translator.translate["ADDITIVES"]! + " (" + _additives!.length.toString() + ")",
                                                textAlign: TextAlign.left,
                                                style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold, fontSize: 16))))
                                ])),
                          Container(
                              height: ((_additives!.length+1) * 50).roundToDouble(),
                              padding: const EdgeInsets.only(left: 15, top: 5, right: 10, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Expanded(
                                    child:  ListView.builder(
                                      itemCount: _additives!.length,
                                      itemBuilder: (context, index) {
                                        return ListTileTheme(
                                          dense: true,
                                          contentPadding: EdgeInsets.all(-10),
                                          child: ExpansionTile (
                                            key: keyTile,
                                            initiallyExpanded: false,
                                            leading: _getAdditiveIcon(_additives![index]),
                                            title: Transform.translate(
                                                offset: Offset(-25, 0),
                                                child:  RichText(
                                                  text: TextSpan( text: "",
                                                    style: DefaultTextStyle.of(context).style,
                                                    children: <TextSpan>[
                                                      TextSpan(text: _additives![index].replaceAll("en:", "").toUpperCase() + " - " + _getName(_additives![index]),
                                                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey[800], fontSize: 14)),
                                                      TextSpan(text: " (" + _getCategory(_additives![index]) + ")",
                                                        style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.normal, color: Colors.grey[700], fontSize: 11),),
                                                    ],
                                                  ),
                                                )
                                            ),
                                            // Text(getAdditive(_additives[index]), style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 13))),
                                            children: <Widget>[
                                              ListTile(
                                                  dense: true,
                                                  contentPadding: EdgeInsets.only(left: 0, right: 15),
                                                  title: Transform.translate(
                                                    offset: Offset(0, 0),child:
                                                  Container(
                                                      child:
                                                      RichText(
                                                        text: TextSpan( text: "",
                                                          style: DefaultTextStyle.of(context).style,
                                                          children: <TextSpan>[
                                                            TextSpan(text: Translator.translate["ADDITIVE_HEALTH_RISKS"], style: TextStyle(fontStyle: FontStyle.normal,
                                                                fontWeight: FontWeight.bold, color: Colors.grey[600], fontSize: 11)),
                                                            TextSpan(text: _getHealthRisks(_additives![index]),
                                                              style: TextStyle(fontStyle: FontStyle.italic, fontWeight: FontWeight.bold,
                                                                  color: _getToxicityColor(_additives![index]), fontSize: 11),),
                                                            TextSpan(text: "\n\n" + Translator.translate["ADDITIVE_DESCRIPTION"]! ,
                                                                style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold,
                                                                    color: Colors.grey[600], fontSize: 11)),
                                                            TextSpan(text: _getDescription(_additives![index]) + "\n"
                                                              ,style: TextStyle(fontStyle: FontStyle.normal, color: Colors.grey[800], fontSize: 11),)
                                                          ],
                                                        ),
                                                      )
                                                  ),
                                                  )
                                              ),

                                            ],

                                          ),

                                        );
                                      },
                                    ),
                                  ),
                                ],
                              )
                          )
                        ],
                      )

                      )
                  ),
                  ConditionalContainer(
                      condition: _allergenes!.isNotEmpty,
                      child:
                      Card(
                          child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Container(
                                color: Colors.grey[200],
                                padding: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
                                child:
                                Row(
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      Icon(Icons.pan_tool, color: Colors.grey[800], size: 18),
                                      SizedBox(width: 10),
                                      Expanded(
                                          child:
                                          Container(
                                              child:      Text(Translator.translate["ALLERGENES"]! + " (" + _allergenes!.length.toString() + ")",
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.grey[800]))
                                          ))
                                    ])),
                              Container(
                                  padding: const EdgeInsets.only(left: 15, top: 10, right: 10, bottom: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.stretch,
                                        children: [
                                          SizedBox(height: 5),
                                          Text(getAllergenes()),
                                          SizedBox(height: 10)
                                        ],
                                      )
                              )
                          ]
                      ))
                  )
                ]
    );
  }

}
