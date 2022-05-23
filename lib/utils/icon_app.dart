import 'package:flutter/material.dart';

class IconApp extends StatelessWidget {
  final IconData iconData;
  final Color backgroundColor;
  final Color iconColor;
  final double size;
  final double bigSize;
  const IconApp(
      {Key? key,
      required this.iconData,
      this.backgroundColor = const Color(0xFFfcf4e4),
      this.iconColor = const Color(0xFF756d54),
      this.size = 40.0,
      this.bigSize = 16.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size / 2),
          color: backgroundColor),
      child: Icon(
        iconData,
        color: iconColor,
        size: bigSize,
      ),
    );
  }
}
