import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class AddNew extends StatelessWidget {
  List<TextEditingController> new_schedule = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // padding: EdgeInsetsDirectional.only(top: 20, bottom: 20),
        middle: Text(
          "새로운 스케쥴 추가하기",
          style: TextStyle(fontSize: 20),
        ),
        trailing: CupertinoButton(
          child: Icon(
            CupertinoIcons.add,
            size: 35,
          ),
          padding: EdgeInsets.zero,
          onPressed: () async {
            var new_one = Schedule(
              title: new_schedule[0].toString(),
              difficulty: int.parse(new_schedule[1].toString()),
              content: new_schedule[2].toString(),
              date: DateTime.now().toString(),
            );
            await DBhelper().createData(new_one);
          },
        ),
      ),
      body: Column(
        children: [
          CupertinoTextField(
            controller: new_schedule[0],
            maxLength: 15,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            placeholder: '제목',
            placeholderStyle: TextStyle(fontSize: 30),
            style: TextStyle(fontSize: 30),
          ),
          CupertinoTextField(
            controller: new_schedule[1],
            maxLength: 4,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            placeholder: '피로도',
            placeholderStyle: TextStyle(fontSize: 30),
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: CupertinoTextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 300,
              controller: new_schedule[2],
              textAlignVertical: TextAlignVertical.top,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              placeholder: '할 일 설명',
              placeholderStyle: TextStyle(fontSize: 30),
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
