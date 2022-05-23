import 'package:flutter/material.dart';

class NoDataPage extends StatelessWidget {
  final String imgPath;
  final String text;
  const NoDataPage(
      {Key? key, this.imgPath = 'images/shoppingcart1.jpg', required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(imgPath,
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.22),
        SizedBox(height: MediaQuery.of(context).size.height * 0.03),
        Text(
          text,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.height * 0.0175,
              color: Colors.black87),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
