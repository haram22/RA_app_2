// 하람 //
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class Home_m extends StatefulWidget {
  const Home_m({super.key});

  @override
  State<Home_m> createState() => _Home_mState();
}

class _Home_mState extends State<Home_m> {
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
                              "📑 진행상황 확인하기",
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
                              "📑 할 일",
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
                                              color: Colors.deepOrange),
                                          highlightedTextStyle: TextStyle(
                                              fontSize: 20,
                                              color: Colors.yellow),
                                          spacing: 50,
                                          itemHeight: 80,
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
                                            onPressed: () {
                                              // setState(() {
                                              //   _dateTime
                                              // });
                                            },
                                            child: Text("확인"))
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
                          title: Text("작업자 진행상황 확인"),
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
