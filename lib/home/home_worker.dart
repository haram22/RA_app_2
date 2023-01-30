// 하람 //
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

import '../screen_manager/check_detail.dart';
import '../screen_manager/work_detail.dart';
import '../screen_worker/setting_w.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';

class Home_w extends StatefulWidget {
  final String name;
  const Home_w({super.key, required this.name});

  @override
  State<Home_w> createState() => _Home_wState();
}

enum SingingCharacter { ten, fifteen, twenty, none }

DateTime _selectedValue = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedValue);

class _Home_wState extends State<Home_w> {
  SingingCharacter? _character = SingingCharacter.ten;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  DatePickerController _controller = DatePickerController();
  DateTime _dateTime = DateTime.now();
  List todos = [];
  String input = "";

  // getData() async {
  //   var result = await FirebaseFirestore.instance
  //       .collection('manager')
  //       .doc('manager2')
  //       .get();
  //   print(result);
  // }

  @override
  void initState() {
    super.initState();
    todos.add("안전모 닦기");
    // getData();
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
      body: SingleChildScrollView(
        child: Container(
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
                      "${widget.name}님! 오늘 하루도 안전한 하루 되세요 :)",
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
                      WeeklyDatePicker(
                        selectedDay: _selectedValue,
                        changeDay: (value) => setState(() {
                          formattedDate =
                              DateFormat('yyyy-MM-dd').format(value);
                          _selectedValue = value;
                          print(_selectedValue);
                        }),
                        enableWeeknumberText: false,
                        backgroundColor: Colors.transparent,
                        weekdayTextColor: Colors.black,
                        digitsColor: Colors.black,
                        selectedBackgroundColor: const Color(0xff316A62),
                        selectedDigitColor: Colors.white,
                        weekdays: [
                          "Mon",
                          "Tue",
                          "Wen",
                          "Thu",
                          "Fri",
                          "Sat",
                          "Sun"
                        ],
                        daysInWeek: 7,
                      ),
                    ],
                  ),
                ),
                //오늘의 공지
                SizedBox(
                  height: 260,
                  width: 400,
                  child: Card(
                    color: Color(0xfffcf8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 20, top: 18, bottom: 5),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "📢 오늘의 공지",
                            style: TextStyle(color: Colors.red, fontSize: 17),
                          ),
                          SizedBox(height: 15),
                          Container(
                            height: 60,
                            // width: 0,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      // 날짜에 현 날짜 data 넣기
                                      'manager/manager1/calendar/${formattedDate}/notice')
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  final docs = snapshot.data!.docs;
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return docs[index]['isEmergency']
                                                  .toString() ==
                                              'true'
                                          ? ListTile(
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity(vertical: -4),
                                              title: Text(
                                                  "✔️ " + docs[index]['title'],
                                                  style: TextStyle(
                                                      color: Colors.red)),
                                            )
                                          : Container();
                                    },
                                    itemCount: docs.length,
                                  );
                                } else
                                  return Text('');
                              },
                            ),
                          ),
                          Divider(),
                          Container(
                            height: 90,
                            // width: 0,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      // 날짜에 현 날짜 data 넣기
                                      'manager/manager1/calendar/${formattedDate}/notice')
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  final docs = snapshot.data!.docs;
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return docs[index]['isEmergency']
                                                  .toString() ==
                                              'false'
                                          ? ListTile(
                                              dense: true,
                                              visualDensity:
                                                  VisualDensity(vertical: -4),
                                              title: Text(
                                                "✔️ " + docs[index]['title'],
                                              ),
                                            )
                                          : Container();
                                    },
                                    itemCount: docs.length,
                                  );
                                } else
                                  return Text('');
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                //오늘의 할 일
                SizedBox(
                  height: 300,
                  width: 400,
                  child: Card(
                    color: Color(0xfffcf8ee),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 5,
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, top: 18, bottom: 5),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Text("📑 오늘의 할 일",
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 17)),
                                  Spacer()
                                ],
                              ),
                            ),
                            Container(
                              height: 230,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(
                                        // 날짜에 현 날짜 data 넣기
                                        'worker/${widget.name}/calendar/${formattedDate}/today task')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
                                  if (snapshot.hasData) {
                                    final docs = snapshot.data!.docs;
                                    final managerReference = FirebaseFirestore
                                        .instance
                                        .collection("manager")
                                        .doc("manager1");
                                    final calendarReference = managerReference
                                        .collection("calendar")
                                        .doc(formattedDate.toString());
                                    final workReference = calendarReference
                                        .collection("task")
                                        .doc();

                                    return ListView.builder(
                                        itemCount: docs.length,
                                        itemBuilder: (context, index) {
                                          // for (int i = 0; i < docs.length; i++) {
                                          return ListTile(
                                            dense: true,
                                            visualDensity:
                                                VisualDensity(vertical: -3),
                                            onTap: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return detailPage(
                                                  title: docs[index]['title'],
                                                  contents: docs[index]
                                                      ['content'],
                                                  enrollTime: formattedDate,
                                                  hour: docs[index]['hour']
                                                      .toString(),
                                                  min: docs[index]['min']
                                                      .toString(),
                                                  worker: docs[index]['worker']
                                                      .toString(),
                                                );
                                              }));
                                            },
                                            trailing: IconButton(
                                              onPressed: () {
                                                showModalBottomSheet(
                                                  enableDrag: true,
                                                  isScrollControlled: true,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topLeft: Radius
                                                                  .circular(
                                                                      30.0),
                                                              topRight: Radius
                                                                  .circular(
                                                                      30.0))),
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return StatefulBuilder(
                                                        builder: (BuildContext
                                                                context,
                                                            StateSetter
                                                                myState) {
                                                      return Container(
                                                        height: 350,
                                                        padding:
                                                            EdgeInsets.fromLTRB(
                                                                0, 20, 0, 0),
                                                        child: Column(
                                                          children: <Widget>[
                                                            Text(
                                                              '작업 알림 설정',
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  color: Color(
                                                                      0xff316a62)),
                                                            ),
                                                            Spacer(),
                                                            RadioListTile(
                                                                title: Text(
                                                                    "10분 전에 알리기"),
                                                                value:
                                                                    SingingCharacter
                                                                        .ten,
                                                                groupValue:
                                                                    _character,
                                                                onChanged:
                                                                    (value) {
                                                                  myState(() {
                                                                    setState(
                                                                        () {
                                                                      _character =
                                                                          value;
                                                                    });
                                                                  });
                                                                  print("10");
                                                                  print(
                                                                      _character);
                                                                }),
                                                            RadioListTile(
                                                                title: Text(
                                                                    "15분 전에 알리기"),
                                                                value:
                                                                    SingingCharacter
                                                                        .fifteen,
                                                                groupValue:
                                                                    _character,
                                                                onChanged:
                                                                    (value) {
                                                                  myState(() {
                                                                    setState(
                                                                        () {
                                                                      _character =
                                                                          value;
                                                                    });
                                                                  });
                                                                  print("15");
                                                                  print(
                                                                      _character);
                                                                }),
                                                            RadioListTile(
                                                                title: Text(
                                                                    "20분 전에 알리기"),
                                                                value:
                                                                    SingingCharacter
                                                                        .twenty,
                                                                groupValue:
                                                                    _character,
                                                                onChanged:
                                                                    (value) {
                                                                  myState(() {
                                                                    setState(
                                                                        () {
                                                                      _character =
                                                                          value;
                                                                    });
                                                                    print("20");
                                                                    print(
                                                                        _character);
                                                                  });
                                                                }),
                                                            RadioListTile(
                                                                title:
                                                                    Text("없음"),
                                                                value:
                                                                    SingingCharacter
                                                                        .none,
                                                                groupValue:
                                                                    _character,
                                                                onChanged:
                                                                    (value) {
                                                                  myState(() {
                                                                    setState(
                                                                        () {
                                                                      _character =
                                                                          value;
                                                                    });
                                                                  });
                                                                  print("none");
                                                                  print(
                                                                      _character);
                                                                }),
                                                            Spacer(),
                                                            ElevatedButton(
                                                                style: ElevatedButton
                                                                    .styleFrom(
                                                                  primary: Color(
                                                                      0xff316a62),
                                                                  shape: RoundedRectangleBorder(
                                                                      //모서리를 둥글게
                                                                      borderRadius: BorderRadius.circular(15)),
                                                                  minimumSize:
                                                                      Size(30,
                                                                          36),
                                                                ),
                                                                child:
                                                                    const Text(
                                                                  '확인',
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        17,
                                                                    color: Color(
                                                                        0xffffffff),
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                ),
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  final workerReference = FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "worker")
                                                                      .doc(
                                                                          '${widget.name}');
                                                                  final calReference = workerReference
                                                                      .collection(
                                                                          "calendar")
                                                                      .doc(
                                                                          formattedDate);
                                                                  final todayWork = calReference
                                                                      .collection(
                                                                          "task alarm")
                                                                      .doc(docs[index]
                                                                              [
                                                                              'title']
                                                                          .toString());
                                                                  todayWork
                                                                      .set({
                                                                    "alarm":
                                                                        _character
                                                                            .toString()
                                                                  });

                                                                  //         ==
                                                                  //     '10분 전에 알리기'
                                                                  // ? 10
                                                                  // : _character.toString() ==
                                                                  //         '15분 전에 알리기'
                                                                  //     ? 15
                                                                  //     : _character.toString() ==
                                                                  //             '20분 전에 알리기'
                                                                  //         ? 20
                                                                  //         : _character.toString() == '없음'
                                                                  //             ? 15
                                                                  //             : 0,
                                                                }),
                                                            Spacer()
                                                          ],
                                                        ),
                                                      );
                                                    });
                                                  },
                                                );
                                              },
                                              icon: Icon(
                                                  Icons.more_horiz_rounded),
                                            ),
                                            leading: Icon(
                                              Icons.check_box_outlined,
                                              color:
                                                  // docs[index]['isComplete']
                                                  //             .toString() ==
                                                  //         "완료"
                                                  //     ? Color(0xffe8c869)
                                                  // :
                                                  Colors.grey,
                                            ),
                                            title: Text(docs[index]['title']),
                                            subtitle: Text(
                                              "${docs[index]['hour']} : ${docs[index]['min']} 까지",
                                              style: TextStyle(fontSize: 12),
                                            ),
                                          );
                                        }
                                        // }

                                        // itemCount: docs.length,

                                        );
                                  } else
                                    return Text('');
                                },
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 250,
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
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet<void>(
                                        isScrollControlled: true,
                                        context: context,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusDirectional.only(
                                            topEnd: Radius.circular(25),
                                            topStart: Radius.circular(25),
                                          ),
                                        ),
                                        builder: (BuildContext context) {
                                          return Container(
                                            padding: const EdgeInsets.all(20),
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.4,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: <Widget>[
                                                const Text(
                                                  '나의 할 일 추가하기',
                                                  style: TextStyle(
                                                      fontSize: 20,
                                                      color: Color(0xff316a62)),
                                                ),
                                                SizedBox(height: 40),
                                                Container(
                                                  height: 100,
                                                  child: TextField(
                                                      onChanged:
                                                          (String value) {
                                                        input = value;
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        border:
                                                            UnderlineInputBorder(),
                                                        filled: true,
                                                        fillColor:
                                                            Colors.grey[100],
                                                        labelText: '할 일을 추가하기',
                                                      )),
                                                ),
                                                Spacer(),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.end,
                                                    children: <Widget>[
                                                      ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary:
                                                              Color(0xff316a62),
                                                          shape:
                                                              RoundedRectangleBorder(
                                                                  //모서리를 둥글게
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              15)),
                                                          minimumSize:
                                                              Size(30, 36),
                                                        ),
                                                        child: const Text(
                                                          '취소',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(
                                                                0xffffffff),
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                      ),
                                                      SizedBox(width: 20),
                                                      ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            primary: Color(
                                                                0xff316a62),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                                    //모서리를 둥글게
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            15)),
                                                            minimumSize:
                                                                Size(30, 36),
                                                          ),
                                                          child: const Text(
                                                            '저장',
                                                            style: TextStyle(
                                                              fontSize: 17,
                                                              color: Color(
                                                                  0xffffffff),
                                                            ),
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                          onPressed: () {
                                                            final workerReference =
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        "worker")
                                                                    .doc(
                                                                        '${widget.name}');
                                                            final calReference =
                                                                workerReference
                                                                    .collection(
                                                                        "calendar")
                                                                    .doc(
                                                                        formattedDate);
                                                            final todayMyTodo =
                                                                calReference
                                                                    .collection(
                                                                        "내가 추가한 일")
                                                                    .doc(input
                                                                        .toString());
                                                            todayMyTodo.set({
                                                              "할 일 ": input
                                                                  .toString(),
                                                              "isComplete":
                                                                  false,
                                                            });
                                                            setState(() {
                                                              todos.add(input);
                                                            });
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        });
                                  },
                                  icon: Icon(Icons.add),
                                ),
                                Spacer()
                              ],
                            ),
                            Container(
                              height: 100,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        // physics: NeverScrollableScrollPhysics(),
                                        shrinkWrap: true,
                                        itemCount: todos.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return Dismissible(
                                              // 삭제 버튼 및 기능 추가
                                              key: Key(todos[index]),
                                              child: ListTile(
                                                leading: Checkbox(
                                                    // fillColor: Colors.yellow,
                                                    // fillColor: Colors.yellow,
                                                    activeColor:
                                                        Colors.yellow[700],
                                                    value: _isChecked2,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        _isChecked2 = value!;
                                                      });
                                                    }),
                                                title: Text(todos[index]),
                                                trailing: IconButton(
                                                    icon: Icon(Icons.delete,
                                                        color: Colors.red),
                                                    onPressed: () {
                                                      setState(() {
                                                        todos.removeAt(index);
                                                      });
                                                    }),
                                                // elevation: 4,
                                                // margin: EdgeInsets.all(8),
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8)),
                                                // child: ListTile(
                                                //   title: Text(todos[index]),
                                                //   trailing: IconButton(
                                                //       icon: Icon(Icons.delete,
                                                //           color: Colors.red),
                                                //       onPressed: () {
                                                //         setState(() {
                                                //           todos.removeAt(index);
                                                //         });
                                                //       }),
                                                // )
                                              ));
                                        }),
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
