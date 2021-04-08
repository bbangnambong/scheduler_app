import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:schedulcok/DBhelper.dart';
import 'package:schedulcok/schedule.dart';
import 'package:schedulcok/table_calendar.dart';

class AddNew extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController difficultyController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  Color textFieldColor = Colors.transparent;
  Color textColor = Colors.grey[50];
  Color placeHolderColor = Colors.grey[350];

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
            int id_ = (await DBhelper().getID()) + 1;
            List<String> _titleCon = titleController.text.split(" ");
            String _date = DateTime.now().month.toString();
            String _day;
            String _title = " ";
            if (num.tryParse(_titleCon[0]) != null) {
              _day = num.tryParse(_titleCon[0]).toString();
              _date = '';
              for (int i = 1; i < _titleCon.length; i++) {
                _title += _titleCon[i];
              }
            } else {
              _day = DateTime.now().day.toString();
              for (int i = 0; i < _titleCon.length; i++) {
                _title += _titleCon[i];
              }
            }
            if (_day.length == 1 || _day.length == 3) _day = '0' + _day;
            _date = _date + _day;
            var new_one = Schedule(
              id: id_,
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
                    maxLength: 1,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    placeholder: '우선순위',
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
