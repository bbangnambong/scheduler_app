import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class Listed extends StatefulWidget {
  @override
  _ListedState createState() => _ListedState();
}

class _ListedState extends State<Listed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Platform.isIOS
          ? CupertinoNavigationBar(
              middle: Text("일정 리스트"),
            )
          : AppBar(
              title: Text("일정 리스트"),
            ),
      body: FutureBuilder(
        future: DBhelper().readAllSchedule(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return scheduleBox(snapshot.data[index]);
              },
            );
          }
          return GFLoader(
            type: GFLoaderType.ios,
            size: 80,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBhelper().deleteAllSchedule();
          setState(() {});
        },
        child: Icon(Icons.delete),
      ),
    );
  }

  Widget scheduleBox(Schedule schedule) {
    return Column(
      children: [
        Text(schedule.title != null ? schedule.title : '불러오기 오류'),
        Text(schedule.difficulty != null ? schedule.difficulty : '불러오기 오류'),
        Text(schedule.content != null ? schedule.content : '불러오기 오류'),
        Text(schedule.date != null ? schedule.date : '불러오기 오류'),
      ],
    );
  }
}
