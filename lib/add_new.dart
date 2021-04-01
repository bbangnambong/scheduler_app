import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class AddNew extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int id_ = 0;

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
          onPressed: () {
            var new_one = Schedule(
              id: id_++,
              title: titleController.text,
              difficulty: difficultyController.text,
              content: contentController.text,
              date: DateTime.now().toString(),
            );
            DBhelper().createData(new_one);

            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          CupertinoTextField(
            controller: titleController,
            maxLength: 15,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            placeholder: '제목',
            placeholderStyle: TextStyle(fontSize: 30, color: Colors.grey),
            style: TextStyle(fontSize: 30),
          ),
          CupertinoTextField(
            controller: difficultyController,
            maxLength: 4,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            placeholder: '피로도',
            placeholderStyle: TextStyle(fontSize: 30, color: Colors.grey),
            style: TextStyle(fontSize: 30),
          ),
          Expanded(
            child: CupertinoTextField(
              keyboardType: TextInputType.multiline,
              maxLines: null,
              maxLength: 300,
              controller: contentController,
              textAlignVertical: TextAlignVertical.top,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              placeholder: '할 일 설명',
              placeholderStyle: TextStyle(fontSize: 30, color: Colors.grey),
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
