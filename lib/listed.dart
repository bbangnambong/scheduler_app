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
      appBar: CupertinoNavigationBar(
        middle: Text("일정 리스트"),
      ),
      body: FutureBuilder(
        future: DBhelper().readAllSchedule(),
        builder:
            (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                final item = snapshot.data[index];
                return Dismissible(
                  key: UniqueKey(),
                  onDismissed: (direction) async {
                    await DBhelper().deleteSchedule(item.id);
                  },
                  child: scheduleBox(snapshot.data[index]),
                );
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
    var diff = schedule.difficulty;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            color: Colors.amber[900],
            borderRadius: new BorderRadius.all(
              const Radius.circular(40.0),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              schedule.title != null ? schedule.title : '불러오기 오류',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              schedule.difficulty != null ? '피로도 : $diff' : '불러오기 오류',
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.right,
            ),
            SizedBox(height: 20),
            Text(
              schedule.content != null ? schedule.content : '불러오기 오류',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
