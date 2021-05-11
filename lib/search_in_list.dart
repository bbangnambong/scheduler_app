import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class SearchInList extends StatefulWidget {
  @override
  _SearchInListState createState() => _SearchInListState();
}

class _SearchInListState extends State<SearchInList> {
  List<Schedule> searchedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(middle: Text("검색")),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Column(
            children: [
              CupertinoSearchTextField(
                backgroundColor: HexColor("f08080").withOpacity(0.5),
                onChanged: (value) async {
                  searchedList = await searchedSchedule(value);
                  setState(() {});
                },
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(child: searchedResult()),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchedResult() {
    if (searchedList.length != 0) {
      return ListView.builder(
        itemCount: searchedList.length,
        itemBuilder: (BuildContext context, int index) {
          final item = searchedList[index];
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.redAccent[200],
                  borderRadius: new BorderRadius.all(
                    Radius.circular(30),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.title != null ? item.title : '불러오기 오류',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      // Text(
                      //   item.difficulty != null ? '우선순위 : $diff' : '불러오기 오류',
                      //   style: TextStyle(
                      //     color: textColor,
                      //     fontSize: 18,
                      //   ),
                      //   textAlign: TextAlign.right,
                      // ),
                      SizedBox(width: 8)
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(child: SizedBox()),
                      Text(
                        item.date != null ? item.date : '불러오기 오류',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.right,
                      ),
                      SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    item.content != null ? item.content : '불러오기 오류',
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
        },
      );
    } else
      return Container();
  }

  Future<List<Schedule>> searchedSchedule(String value) async {
    List<Schedule> result = [];
    if (value == '') {
      return result;
    }
    List<Schedule> allList = await DBhelper().readAllSchedule();
    List<Schedule> allDoneList = await DBhelper().readAllDoneSchedule();
    for (int i = 0; i < allList.length; i++) {
      if (allList[i].title.contains(value) == true ||
          allList[i].content.contains(value) == true) {
        result.add(allList[i]);
      }
    }
    for (int i = 0; i < allDoneList.length; i++) {
      if (allDoneList[i].title.contains(value) == true ||
          allDoneList[i].content.contains(value) == true) {
        result.add(allDoneList[i]);
      }
    }
    return result;
  }
}
