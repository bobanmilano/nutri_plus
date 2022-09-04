import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'conditional_container.dart';

class ColoredIndicator extends StatefulWidget {
  final String? level;
  const ColoredIndicator({Key? key, this.level}) : super(key: key);

  @override
  _ColoredIndicatorState createState() => _ColoredIndicatorState();
}

class _ColoredIndicatorState extends State<ColoredIndicator> {
  String? _level;
  Color? _color;

  void initState() {
    _level = widget.level;
    switch(_level) {
      case "high":
        _color = Colors.red;
        break;
      case "low":
        _color = Colors.green;
        break;
      case "moderate":
        _color = Colors.orange;
        break;
      case "undefined":
        _color = Colors.white54;
        break;
      default:
        _color = Colors.grey;
        break;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return
      Container(
        width: 22,
        height: 22,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _color
        ),
        alignment: Alignment.center
      );
  }
}
