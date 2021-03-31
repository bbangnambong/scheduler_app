import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class Listed extends StatelessWidget {
  List<Schedule> scheduleInfo = [
    Schedule(
      title: "컴퓨터 구조 과제",
      difficulty: 30,
      content: "컴퓨터 구조의 과제를 한다",
      date: DateTime.now().toString(),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text("Listed"),
            )
          : AppBar(
              title: Text("Listed"),
            ),
      body: ListView.builder(
        itemCount: scheduleInfo.length,
        itemBuilder: (BuildContext context, int index) {
          return GFCard(
            title: GFListTile(
              title: Text(scheduleInfo[index].title),
              subtitle: Text(scheduleInfo[index].difficulty.toString()),
            ),
            content: Text(scheduleInfo[index].content),
          );
        },
      ),
    );
  }
}

resc() async {
  List<Schedule> scin = await DBhelper().readAllSchedule();
  return scin;
}
