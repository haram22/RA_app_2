// 하람 //
///
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../screen_manager/manager_home.dart';

class Home_w extends StatefulWidget {
  const Home_w({super.key});

  @override
  State<Home_w> createState() => _Home_wState();
}

class _Home_wState extends State<Home_w> {
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  DatePickerController _controller = DatePickerController();
  DateTime _dateTime = DateTime.now();

  DateTime _selectedValue = DateTime.now();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Chip(label: Text("관리자에게 문의하기")),
              Icon(Icons.notifications, color: Colors.red[200], size: 30),
              SizedBox(width: 20)
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20.0, right: 20),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Manager_home()));
              },
              child: Text('성경파트 바로가기'),
            ),
            SizedBox(
              height: 50,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Text(
                      "🚨  긴급",
                      style: TextStyle(color: Colors.red),
                    ),
                    SizedBox(width: 20),
                    Text("3번 작업장 기계2 부품 고장")
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 100.0, top: 10),
              child: Text("00님! 오늘 하루도 안전한 하루 되세요 :)"),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.0, right: 280),
              child: Image.asset(
                'assets/profile.png',
                width: 50,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(right: 280.0),
              child: Text("나"),
            ),
            Container(
              padding: EdgeInsets.all(20.0),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Padding(
                  //   padding: EdgeInsets.all(10),
                  // ),
                  Text(_selectedValue.toString()),
                  // Padding(
                  //   padding: EdgeInsets.all(20),
                  // ),
                  Container(
                    child: DatePicker(
                      DateTime.now(),
                      // width: 60,
                      height: 80,
                      controller: _controller,
                      initialSelectedDate: DateTime.now(),
                      selectionColor: Colors.black,
                      selectedTextColor: Colors.white,
                      inactiveDates: [
                        // DateTime.now().add(Duration(days: 3)),
                        // DateTime.now().add(Duration(days: 4)),
                        // DateTime.now().add(Duration(days: 7))
                      ],
                      onDateChange: (date) {
                        // New date selected
                        setState(() {
                          _selectedValue = date;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.only(left: 18.0, top: 18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 20),
                      Text(
                        "📢 오늘의 공지",
                        style: TextStyle(color: Colors.red, fontSize: 17),
                      ),
                      SizedBox(height: 10),
                      Text("✔️ 3번 작업장 기계2 부품 고장")
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "📑 오늘의 할 일",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            Spacer()
                          ],
                        ),
                        ListTile(
                          trailing: IconButton(
                            onPressed: () {},
                            icon: Icon(Icons.more_horiz_rounded),
                          ),
                          leading: Checkbox(
                              // fillColor: Colors.yellow,
                              value: _isChecked1,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked1 = value!;
                                });
                              }),
                          title: Text("3번 작업장 청소"),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                child: Padding(
                    padding: const EdgeInsets.only(left: 18.0, top: 18),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              "📑 내가 추가한 일",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 17),
                            ),
                            Spacer()
                          ],
                        ),
                        ListTile(
                          trailing: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        // Text({_dateTime}),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        TimePickerSpinner(
                                          is24HourMode: false,
                                          normalTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.black),
                                          highlightedTextStyle: TextStyle(
                                              fontSize: 20, color: Colors.blue),
                                          spacing: 20,
                                          itemHeight: 50,
                                          isForce2Digits: true,
                                          onTimeChange: (time) {
                                            setState(() {
                                              _dateTime = time;
                                            });
                                          },
                                        ),
                                        Text(
                                          _dateTime.hour
                                                  .toString()
                                                  .padLeft(2, '0') +
                                              ':' +
                                              _dateTime.minute
                                                  .toString()
                                                  .padLeft(2, '0'),
                                          style: TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        TextButton(
                                            onPressed: () {}, child: Text("확인"))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(Icons.more_horiz_rounded),
                          ),
                          leading: Checkbox(
                              // fillColor: Colors.yellow,
                              value: _isChecked2,
                              onChanged: (bool? value) {
                                setState(() {
                                  _isChecked2 = value!;
                                });
                              }),
                          title: Text("안전모 닦기"),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: ,
    );
  }
}
