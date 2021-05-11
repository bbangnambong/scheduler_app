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
    return Container(
      child: futureSchedule(3),
    );
  }

  Widget scheduleBox(Schedule schedule, int index) {
    Color textColor = Colors.grey[100];
    var diff = schedule.difficulty;
    var dat = schedule.date;
    double _radius;
    double _padding;
    Color todayColor = Colors.red;
    Color boxColor, reboxColor;
    String _day = DateTime.now().day.toString();
    String _date = DateTime.now().month.toString();
    if (_day.length == 1) _day = '0' + _day;
    if (_date.length == 1) _date = '0' + _date;
    (_date + _day) == dat
        ? boxColor = todayColor
        : boxColor = HexColor("F08080");
    if (index < 7) {
      _radius = 30 + 5 * index.toDouble();
      _padding = 9 + 1.2 * index.toDouble();
      reboxColor = boxColor.withOpacity(1 - 0.07 * index);
    } else {
      _radius = 30 + 5 * 7.0;
      _padding = 9 + 1.2 * 7.0;
      reboxColor = boxColor.withOpacity(1 - 0.07 * 7);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _padding, vertical: 6),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        decoration: BoxDecoration(
            color: reboxColor,
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
                  schedule.difficulty != null ? '소요시간 : $diff' : '불러오기 오류',
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

  Widget futureSchedule(int sortBy) {
    // 1:기한 오름차순, 2: 기한 내림차순 3:default
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
                key: Key(item.id.toString()),
                onDismissed: (direction) async {
                  await DBhelper().movetoOld(item);
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
