import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';

class AddNew extends StatelessWidget {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController difficultyController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final Color textFieldColor = Colors.transparent;
  final Color textColor = Colors.grey[50];
  final Color placeHolderColor = Colors.grey[350];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        backgroundColor: Colors.transparent,
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
            int _id = (await DBhelper().getID()) + 1;
            List<String> _titleCon = titleController.text.split(" ");
            String _date;
            String _day;
            String _title = " ";
            if (num.tryParse(_titleCon[0]) != null) {
              _date = num.tryParse(_titleCon[0]).toString();
              for (int i = 1; i < _titleCon.length; i++) {
                _title += (_titleCon[i] + " ");
              }
            } else {
              _day = DateTime.now().day.toString();
              _date = DateTime.now().month.toString();
              if (_day.length == 1) _day = '0' + _day;
              for (int i = 0; i < _titleCon.length; i++) {
                _title += (_titleCon[i] + " ");
              }
            }
            if (_date.length == 1 || _date.length == 3) _date = '0' + _date;
            if (_day != null) _date = _date + _day;
            var new_one = Schedule(
              id: _id,
              title: _title,
              difficulty: difficultyController.text,
              content: contentController.text,
              date: _date,
            );
            DBhelper().createData(new_one);
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
            color: HexColor('f08080'),
            borderRadius: new BorderRadius.all(
              Radius.circular(30),
            )),
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
        child: Column(
          children: [
            CupertinoTextField(
              controller: titleController,
              maxLength: 25,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              placeholder: '제목',
              placeholderStyle:
                  TextStyle(fontSize: 30, color: placeHolderColor),
              style: TextStyle(fontSize: 30, color: textColor),
              decoration: BoxDecoration(color: textFieldColor),
            ),
            Container(height: 2, color: textColor),
            Row(
              children: [
                Expanded(
                  child: CupertinoTextField(
                    controller: difficultyController,
                    maxLength: 5,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    placeholder: '소요시간(00~00)',
                    placeholderStyle:
                        TextStyle(fontSize: 30, color: placeHolderColor),
                    style: TextStyle(fontSize: 30, color: textColor),
                    decoration: BoxDecoration(color: textFieldColor),
                  ),
                ),
                // CupertinoButton(
                //   child: Icon(Icons.calendar_today),
                //   onPressed: () {
                //     Navigator.of(context).push(
                //         CupertinoPageRoute(builder: (context) => CalendarPage()));
                // },
                // ),
              ],
            ),
            Container(height: 2, color: textColor),
            Expanded(
              child: CupertinoTextField(
                keyboardType: TextInputType.multiline,
                maxLines: null,
                maxLength: 300,
                controller: contentController,
                textAlignVertical: TextAlignVertical.top,
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                placeholder: '할 일 설명',
                placeholderStyle:
                    TextStyle(fontSize: 30, color: placeHolderColor),
                style: TextStyle(fontSize: 30, color: textColor),
                decoration: BoxDecoration(color: textFieldColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
