import 'package:flutter/material.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/small_text.dart';
import 'package:foody_flutter/widget/status_foody.dart';

class ColumApp extends StatelessWidget {
  final String text;
  const ColumApp({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: Dimission.height26,
        ),
        SizedBox(
          height: Dimission.height10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Wrap(
              children: List.generate(
                  5,
                  (index) => Icon(
                        Icons.star,
                        size: 15.0,
                        color: Color.fromARGB(255, 44, 216, 202),
                      )),
            ),
            SmallText(text: '4.5'),
            SmallText(text: '1234 comments'),
          ],
        ),
        SizedBox(
          height: Dimission.height15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatusFoody(
                icon: Icons.circle_sharp,
                text: 'Normal',
                color: Color(0xFFccc7c5),
                iconColor: Colors.yellow),
            StatusFoody(
                icon: Icons.location_on,
                text: '1 km',
                color: Color(0xFFccc7c5),
                iconColor: Color.fromARGB(255, 44, 216, 202)),
            StatusFoody(
                icon: Icons.access_time_rounded,
                text: '32 min',
                color: Color(0xFFccc7c5),
                iconColor: Colors.red),
          ],
        )
      ],
    );
  }
}
