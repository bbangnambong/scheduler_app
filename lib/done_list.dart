import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:getwidget/getwidget.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';
import 'package:schedulcok/search_in_list.dart';

class DoneListed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CupertinoNavigationBar(
            middle: Text("완료한 리스트"),
            backgroundColor: Colors.transparent,
            trailing: CupertinoButton(
              padding: EdgeInsets.only(bottom: 0),
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => SearchInList()));
              },
              child: Icon(
                Icons.search,
                size: 25,
              ),
            )),
        body: FutureBuilder(
          future: DBhelper().readAllDoneSchedule(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data[index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      decoration: BoxDecoration(
                          color: Colors.grey[800],
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
            }
            return GFLoader(
              type: GFLoaderType.ios,
              size: 80,
            );
          },
        ));
  }
}
