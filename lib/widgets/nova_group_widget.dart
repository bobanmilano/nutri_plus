import 'package:flutter/material.dart';
import '../lang/translator.dart';
import '../util/helpers.dart';
import '../util/constants.dart' as CONSTANTS;

class NovaGroupWidget extends StatefulWidget {
  final int? score;

  NovaGroupWidget({this.score});

  @override
  _NovaGroupWidgetState createState() => _NovaGroupWidgetState();
}

class _NovaGroupWidgetState extends State<NovaGroupWidget> {
  int? _score = -1;

  void initState() {
    _score =  widget.score;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _score != -1 ? Container (
      child: Row(
        children: <Widget> [
          InkWell(
              splashColor: Colors.blue.withAlpha(30),
              child: SizedBox(
                width: 45,
                height: 63,
                child: Image(image: Helpers.getNovaImage(_score.toString()),
                    fit: BoxFit.contain),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Text(Translator.translate["NOVA_" + (_score).toString()]!)
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
                  width: 40,
                  height: 53,
                  child: Image(image: Helpers.getNovaImage(""),
                      fit: BoxFit.contain),
                ),
              ),
              SizedBox(width: 15),
              Flexible(
                child: Text(CONSTANTS.NOVA_SCORE_UNKNOWN)
              )
            ]
        )
    );

  }

}

