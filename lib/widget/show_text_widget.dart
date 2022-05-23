import 'package:flutter/material.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/widget/small_text.dart';

class ShowTextWidget extends StatefulWidget {
  final String text;
  const ShowTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  _ShowTextWidgetState createState() => _ShowTextWidgetState();
}

class _ShowTextWidgetState extends State<ShowTextWidget> {
  late String firstText;
  late String lastText;
  bool hiddenText = true;
  double textHeight = Dimission.pageViewTextContainer;

  @override
  void initState() {
    super.initState();
    if (widget.text.length > textHeight) {
      firstText = widget.text.substring(0, textHeight.toInt());
      lastText =
          widget.text.substring(textHeight.toInt() + 1, widget.text.length);
    } else {
      firstText = widget.text;
      lastText = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: lastText.isEmpty
          ? SmallText(
              text: firstText,
              size: Dimission.iconSize16,
              color: Colors.black87,
            )
          : Column(
              children: [
                SmallText(
                    size: Dimission.iconSize16,
                    color: Colors.black87,
                    height: 1.8,
                    text: hiddenText
                        ? (firstText + '...')
                        : (firstText + lastText)),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    children: [
                      SmallText(
                          text: 'Show more',
                          color: Color.fromARGB(255, 9, 173, 146)),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Color.fromARGB(255, 14, 179, 151),
                      )
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
