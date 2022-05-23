import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foody_flutter/home/foody_page_body.dart';
import 'package:foody_flutter/utils/dimission.dart';
import 'package:foody_flutter/widget/big_text.dart';
import 'package:foody_flutter/widget/small_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  MainPage_State createState() => MainPage_State();
}

class MainPage_State extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    // print("height " + MediaQuery.of(context).size.width.toString());
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Container(
              margin: EdgeInsets.fromLTRB(
                  0, Dimission.height45, 0, Dimission.height15),
              padding: EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      BigText(
                        text: "Viet Nam",
                        size: 25.0,
                        color: Color.fromARGB(255, 12, 161, 149),
                      ),
                      Row(
                        children: [
                          SmallText(
                            text: "Ha Noi",
                            color: Color.fromARGB(137, 122, 120, 120),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black87,
                          )
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: Container(
                      width: Dimission.height45,
                      height: Dimission.height45,
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                      ),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimission.height15),
                          color: Color.fromARGB(255, 11, 163, 151)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
            child: FoodyPageBody(),
          )),
        ],
      ),
    );
  }
}
