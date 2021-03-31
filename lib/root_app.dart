import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:getwidget/getwidget.dart';
import 'package:schedulcok/add_new.dart';
import 'package:schedulcok/listed.dart';

class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: basicMenu(),
    );
  }

  Widget basicMenu() {
    List<Widget> basic_menus = [
      GFIconButton(
        padding: EdgeInsets.symmetric(horizontal: 10),
        size: GFSize.LARGE,
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (context) => AddNew()));
        },
        color: GFColors.PRIMARY,
        shape: GFIconButtonShape.pills,
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: GFButton(
          text: "리스트",
          textStyle: TextStyle(fontSize: 17),
          onPressed: () {
            Navigator.of(context)
                .push(CupertinoPageRoute(builder: (context) => Listed()));
          },
          size: GFSize.LARGE,
          color: GFColors.WARNING,
          shape: GFButtonShape.pills,
        ),
      ),
      SizedBox(
        width: 20,
      ),
      Expanded(
        child: GFButton(
          text: "공유하기",
          textStyle: TextStyle(fontSize: 17),
          onPressed: () {},
          size: GFSize.LARGE,
          color: GFColors.WARNING,
          shape: GFButtonShape.pills,
        ),
      ),
      SizedBox(
        width: 20,
      ),
      GFIconButton(
        icon: Icon(Icons.settings),
        onPressed: () {},
        color: GFColors.SUCCESS,
        shape: GFIconButtonShape.pills,
      )
    ];

    return Container(
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(color: Colors.transparent),
      child: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: basic_menus),
      ),
    );
  }
}
