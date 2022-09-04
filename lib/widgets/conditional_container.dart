import 'package:flutter/material.dart';

class ConditionalContainer extends StatelessWidget {
  final bool? condition;
  final Widget? child;

  ConditionalContainer({this.condition, this.child});

  @override
  Widget build(BuildContext context) {
    if(condition!) {
      return child!;
    }
    return SizedBox();
  }
}
