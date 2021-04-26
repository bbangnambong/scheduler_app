import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schedulcok/add_new.dart';
import 'package:schedulcok/done_list.dart';
import 'package:schedulcok/listed.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        middle: Text("오늘의 할 일"),
        backgroundColor: Colors.transparent,
      ),
      body: Listed(),
      bottomNavigationBar: basicMenu(),
    );
  }

  Color coral = HexColor("5f9ea0");
  Color textColor = Colors.grey[100];
  Widget basicMenu() {
    List<Widget> basicMenus = [
      GFIconButton(
        padding: EdgeInsets.symmetric(horizontal: 10),
        size: GFSize.LARGE,
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (context) => AddNew()))
              .then((value) => setState(() {}));
        },
        color: HexColor('5b92e4'),
        shape: GFIconButtonShape.pills,
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: GFButton(
          text: "완료한 리스트",
          textStyle: TextStyle(fontSize: 17, color: textColor),
          onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => DoneListed()))
                .then((value) => setState(() {}));
            ;
          },
          size: GFSize.LARGE,
          color: coral,
          shape: GFButtonShape.pills,
        ),
      ),
      // SizedBox(
      //   width: 20,
      // ),
      // GFButton(
      //   padding: EdgeInsets.symmetric(horizontal: 10),
      //   text: "공유",
      //   textStyle: TextStyle(fontSize: 17, color: textColor),
      //   onPressed: () {},
      //   size: GFSize.LARGE,
      //   color: coral,
      //   shape: GFButtonShape.pills,
      // ),
      // SizedBox(
      //   width: 20,
      // ),
      // GFIconButton(
      //   icon: Icon(Icons.settings),
      //   onPressed: () {},
      //   color: GFColors.SUCCESS,
      //   shape: GFIconButtonShape.pills,
      // )
    ];

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: basicMenus),
      ),
    );
  }
}
