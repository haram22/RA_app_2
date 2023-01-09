
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';


import '../screen_manager/check_detail.dart';
import '../screen_manager/manager_home.dart';
import '../screen_manager/work_detail.dart';
import '../screen_worker/setting_w.dart';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:flutter/material.dart';

class home_worker extends StatefulWidget {
  const home_worker({super.key});

  @override
  State<home_worker> createState() => _home_workerState();
}

class _home_workerState extends State<home_worker> {
  DatePickerController _controller = DatePickerController();
  DateTime _dateTime = DateTime.now();

  DateTime _selectedValue = DateTime.now();
  List todos = [];
  String input = "";

  @override
  void initState() {
    super.initState();
    todos.add("안전모 닦기");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Color(0xffe8c869),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [

              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return setting_w();
                  }));
                },
                iconSize: 70,
                icon: Image.asset('assets/profile.png'),
              ),

            ],
          )
        ],
      ),

      body: Container(
        color: Color(0xffe8c869),
        child: Padding(
          padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
          child: Column(
            children: [
              //인삿말
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "00님! 오늘 하루도 안전한 하루 되세요 :)",
                    style: TextStyle(fontSize: 15.5),
                  ),
                ],
              ),
              //캘린더
              Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Padding(
                    //   padding: EdgeInsets.all(10),
                    // ),
                    //Text(_selectedValue.toString()),
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
                        selectionColor: Color(0xff316a62),
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
                height: 160,
                width: 400,
                child: Card(
                  color: Color(0xfffcf8ee),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, top: 18, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "📢 오늘의 공지",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -4),
                          onTap: () {},
                          title: Text(
                            "✔️ 3번 작업장 기계2 부품 고장",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        ListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: -4),
                          onTap: () {

                            showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(30),
                                    topStart: Radius.circular(30),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    height: MediaQuery.of(context).size.height*0.4,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        const Text(
                                          '안전모를 꼭 착용하고 작업하시기 바랍니다.',
                                          style: TextStyle(fontSize: 18,color: Color(0xff316a62)),
                                        ),
                                        SizedBox(height: 40),
                                        Container(
                                          alignment: Alignment.topLeft,
                                          height: 100,
                                          child: Text('공지 상세 내용'),
                                        ),
                                        Spacer(),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              primary:Color(0xff316a62),
                                              shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                  borderRadius: BorderRadius.circular(15)),
                                              minimumSize: Size(30, 36),

                                            ),
                                                child: const Text('확인',
                                                  style: TextStyle(
                                                  fontSize: 17,
                                                  color: Color(0xffffffff),
                                                ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                onPressed: () => Navigator.pop(context),
                                              ),
                                      ],
                                    ),
                                  );
                                }
                            );

                          },
                          title: Text(
                            "✔️ 작업 시 안전모를 꼭 착용하세요.",
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 200,
                width: 400,
                child: Card(
                    color: Color(0xfffcf8ee),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  child: Padding(
                      padding:
                          const EdgeInsets.only(left: 18.0, top: 18, bottom: 5),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("📑 오늘의 할 일",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17)),
                              Spacer()
                            ],
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskDetails()));
                            },
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz_rounded),
                            ),
                            leading: Icon(
                              Icons.check_box_outlined,
                              color: Colors.grey,
                            ),
                            title: Text("3번 작업장 청소"),
                            subtitle: Text(
                              "15:30까지",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -3),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TaskDetails()));
                            },
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.more_horiz_rounded),
                            ),
                            leading: Icon(
                              Icons.check_box_outlined,
                              color: Colors.grey,
                            ),
                            title: Text("기계2 부품 확인"),
                            subtitle: Text(
                              "18:00까지",
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ],
                      )),
                ),
              ),
              SizedBox(
                height: 160,
                width: 400,
                child: Card(
                    color: Color(0xfffcf8ee),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
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
                              IconButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(25),
                                          topStart: Radius.circular(25),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: const EdgeInsets.all(20),
                                          height: MediaQuery.of(context).size.height*0.4,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text(
                                                  '나의 할 일 추가하기',
                                                  style: TextStyle(fontSize: 20,color:Color(0xff316a62) ),
                                              ),
                                              SizedBox(height: 40),
                                              Container(
                                                height: 100,
                                                child: TextField(
                                                      decoration: InputDecoration(
                                                      border: UnderlineInputBorder(),
                                                      filled: true,
                                                      fillColor: Colors.grey[100],
                                                      labelText: '할 일을 추가하기',
                                                    )
                                                ),
                                              ),
                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 20),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.end,
                                                  children: <Widget> [
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary:Color(0xff316a62),
                                                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                            borderRadius: BorderRadius.circular(15)),
                                                        minimumSize: Size(30, 36),

                                                      ),
                                                      child: const Text('취소',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0xffffffff),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      onPressed: () => Navigator.pop(context),
                                                    ),
                                                    SizedBox(width: 20),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary:Color(0xff316a62),
                                                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                            borderRadius: BorderRadius.circular(15)),
                                                        minimumSize: Size(30, 36),

                                                      ),
                                                      child: const Text('저장',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0xffffffff),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      onPressed: () => Navigator.pop(context),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                icon: Icon(Icons.add),
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
                          Spacer(),
                        ],
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
      // bottomNavigationBar: ,

   /*   body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
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
                      print("❗️❗️selectedDate: ${_selectedValue}");
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Add Todolist"),
                              content: TextField(
                                onChanged: (String value) {
                                  input = value;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        todos.add(input);
                                      });
                                      final WReference = FirebaseFirestore
                                          .instance
                                          .collection("작업자")
                                          .doc("작업자1");
                                      final calendarReference =
                                          WReference.collection("calendar")
                                              .doc("2023-01-05 00:00:00.000");
                                      final todomaker = calendarReference
                                          .collection("오늘의 할 일")
                                          .doc(input);

                                      todomaker.update({
                                        '할 일': '{input}',
                                      });
                                      // calendarReference.set({"할 일1": input});

                                      Navigator.of(context)
                                          .pop(); // input 입력 후 창 닫히도록
                                    },
                                    child: Text("Add"))
                              ]);
                        });
                  },
                  icon: Icon(Icons.add)),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          // 삭제 버튼 및 기능 추가
                          key: Key(todos[index]),
                          child: Card(
                              elevation: 0.5,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                title: Text(todos[index]),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        todos.removeAt(index);
                                      });
                                    }),
                              )));
                    }),
              ),
            ],
          )), */

    );
  }
}
