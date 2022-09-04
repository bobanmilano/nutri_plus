import 'package:flutter/material.dart';
import '../../util/nutriscore.dart';
import '../util/helpers.dart';
import '../lang/translator.dart';
import '../util/constants.dart' as CONSTANTS;

class NutriScoreWidget extends StatefulWidget {
  final String? score;

  NutriScoreWidget({this.score});

  @override
  _NutriScoreWidgetState createState() => _NutriScoreWidgetState();
}

class _NutriScoreWidgetState extends State<NutriScoreWidget> {
  String? _score;

  void initState() {
    _score = widget.score;
    super.initState();
  }

  String getNutriScoreDescriptionText() {
    switch(_score) {
      case CONSTANTS.a:
        return Translator.translate["NUTRI_SCORE_A"]!;
      case CONSTANTS.b:
        return Translator.translate["NUTRI_SCORE_B"]!;
      case CONSTANTS.c:
        return Translator.translate["NUTRI_SCORE_C"]!;
      case CONSTANTS.d:
        return Translator.translate["NUTRI_SCORE_D"]!;
      case CONSTANTS.e:
        return Translator.translate["NUTRI_SCORE_E"]!;
      default:
        return CONSTANTS.SCORE_UNKNOWN;
    }
  }

  @override
  Widget build(BuildContext context) {

    return _score == null ? Container (
        child: Row(
            children: <Widget> [
              InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  width: 80,
                  height: 53,
                  child: Image(image: Helpers.getNutriImage(_score!),
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
                child: Text(getNutriScoreDescriptionText())
              )
            ]
        )
    ) :
    Container(
        child: Row(
            children: <Widget> [
              InkWell(
                splashColor: Colors.blue.withAlpha(30),
                child: SizedBox(
                  width: 110,
                  height: 60,
                  child: Image(image: Helpers.getNutriImage(_score!),
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 10),
              Flexible(
               child: Text(getNutriScoreDescriptionText())
              )
            ]
        )
    );
  }
}
