import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
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
          middle: Text("일정 리스트"), backgroundColor: Colors.transparent),
      body: future_schedule(3),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          DBhelper().deleteAllSchedule();
          setState(() {});
        },
        child: Icon(Icons.delete),
        backgroundColor: HexColor('5b92e4'),
      ),
    );
  }

  Widget scheduleBox(Schedule schedule, int index) {
    Color textColor = Colors.grey[100];
    var diff = schedule.difficulty;
    var dat = schedule.date;
    double _radius;
    double _padding;
    Color boxColor;
    if (index < 7) {
      _radius = 30 + 5 * index.toDouble();
      _padding = 9 + 1.2 * index.toDouble();
      boxColor = HexColor("F08080").withOpacity(1 - 0.07 * index);
    } else {
      _radius = 30 + 5 * 7.0;
      _padding = 9 + 1.2 * 7.0;
      boxColor = HexColor("F08080").withOpacity(1 - 0.07 * 7);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            color: boxColor,
            borderRadius: new BorderRadius.all(
              Radius.circular(_radius),
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    schedule.title != null ? schedule.title : '불러오기 오류',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  schedule.difficulty != null ? '우선순위 : $diff' : '불러오기 오류',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 8)
              ],
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Text(
                  schedule.date != null ? '$dat' : '불러오기 오류',
                  style: TextStyle(
                    color: textColor,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.right,
                ),
                SizedBox(width: 8),
              ],
            ),
            SizedBox(height: 10),
            Text(
              schedule.content != null ? schedule.content : '불러오기 오류',
              textAlign: TextAlign.left,
              style: TextStyle(
                color: textColor,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget future_schedule(int sortBy) {
    // 1:피로도 오름차순, 2: 피로도 내림차순 3:default
    Future<List<Schedule>> sortedSchedule() async {
      List<Schedule> sortedList = await DBhelper().readAllSchedule();
      if (sortBy == 1) {
        sortedList.sort((a, b) {
          int ad = int.parse(a.difficulty);
          int bd = int.parse(b.difficulty);
          if (ad > bd)
            return 1;
          else if (ad < bd)
            return -1;
          else
            return 0;
        });
      } else if (sortBy == 2) {
        sortedList.sort((a, b) {
          int ad = int.parse(a.difficulty);
          int bd = int.parse(b.difficulty);
          if (ad > bd)
            return -1;
          else if (ad < bd)
            return 1;
          else
            return 0;
        });
      } else if (sortBy == 3) {
        sortedList.sort((a, b) {
          int ad = int.parse(a.date);
          int bd = int.parse(b.date);
          if (ad > bd)
            return 1;
          else if (ad < bd)
            return -1;
          else {
            int av = int.parse(a.difficulty);
            int bv = int.parse(b.difficulty);
            if (av > bv)
              return 1;
            else if (av < bv)
              return -1;
            else
              return 0;
          }
        });
      }
      return sortedList;
    }

    return FutureBuilder(
      future: sortedSchedule(),
      builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
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
                child: scheduleBox(snapshot.data[index], index),
              );
            },
          );
        }
        return GFLoader(
          type: GFLoaderType.ios,
          size: 80,
        );
      },
    );
  }
}
