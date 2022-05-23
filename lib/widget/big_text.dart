// ignore_for_file: prefer_const_constructors_in_immutables

import 'package:flutter/cupertino.dart';

class BigText extends StatelessWidget {
  final Color? color;
  final String text;
  final double size;
  final TextOverflow overFlow;
  BigText(
      {Key? key,
      this.color,
      required this.text,
      this.size = 20.0,
      this.overFlow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          color: color,
          fontSize: size),
    );
  }
}
