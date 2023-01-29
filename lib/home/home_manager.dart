import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';
import 'package:ra_application/screen_manager/check_detail.dart';

import '../screen_manager/add_notice.dart';
import '../screen_manager/add_urgent_alarm.dart';
import '../screen_manager/add_work.dart';
import '../screen_manager/setting_m.dart';
import '../screen_manager/work_detail.dart';
import '../screen_worker/setting_w.dart';
import 'package:weekly_date_picker/weekly_date_picker.dart';
import 'package:intl/intl.dart';

enum SingingCharacter { ten, fifteen, twenty, none }

class Home_m extends StatefulWidget {
  const Home_m({super.key});

  @override
  State<Home_m> createState() => _Home_mState();
}

DateTime now = DateTime.now();
DateTime _selectedValue = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(_selectedValue);
late List<dynamic> name = <dynamic>["김00", "이00", "박00", "정00"];
late List<String> selectedName = <String>[];

class _Home_mState extends State<Home_m> {
  SingingCharacter? _character = SingingCharacter.ten;
  bool _isChecked1 = false;
  bool _isChecked2 = false;
  List<bool> _isCheck = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  DatePickerController _controller = DatePickerController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffe8c869),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return setting_m();
                    }));
                  },
                  iconSize: 70,
                  icon: Image.asset('assets/profile.png'),
                ),
                SizedBox(
                  width: 10,
                )
              ],
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 10, left: 20.0, right: 20),
          child: Column(
            children: [
              Text(
                "관리자님! 오늘 하루도 안전한 하루 되세요 :)",
                style: TextStyle(fontSize: 15.5),
              ),
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
                      child: WeeklyDatePicker(
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 180,
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(width: 20),
                        Text(
                          "📢 오늘의 공지",
                          style: TextStyle(color: Colors.red, fontSize: 17),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 30,
                          // width: 0,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    // 날짜에 현 날짜 data 넣기
                                    '관리자/관리자1/calendar/${formattedDate}/공지')
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
                                    // ListTile(
                                    //   dense: true,
                                    //   visualDensity:
                                    //       VisualDensity(vertical: -4),
                                    //   title:
                                    //       Text("✔️ " + docs[index]['content']),
                                    // );
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
                          height: 30,
                          // width: 0,
                          child: StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection(
                                    // 날짜에 현 날짜 data 넣기
                                    '관리자/관리자1/calendar/${formattedDate}/공지')
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
                                              "✔️ " + docs[index]['content'],
                                            ),
                                          )
                                        : Container();
                                    // ListTile(
                                    //   dense: true,
                                    //   visualDensity:
                                    //       VisualDensity(vertical: -4),
                                    //   title:
                                    //       Text("✔️ " + docs[index]['content']),
                                    // );
                                  },
                                  itemCount: docs.length,
                                );
                              } else
                                return Text('');
                            },
                          ),
                        ),
                        // Text("✔️ 3번 작업장 기계2 부품 고장")
                      ],
                    ),
                  ),
                ),
              ),
              Spacer(
                flex: 1,
              ),
              SizedBox(
                height: 330,
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
                          Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text(
                                  "📑 진행상황 확인하기",
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17),
                                ),
                                Spacer()
                              ],
                            ),
                          ),
                          Container(
                            height: 240,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      // 날짜에 현 날짜 data 넣기
                                      '관리자/관리자1/calendar/${formattedDate}/업무')
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
                                if (snapshot.hasData) {
                                  final docs = snapshot.data!.docs;
                                  return ListView.builder(
                                    itemBuilder: (context, index) {
                                      return ListTile(
                                        dense: true,
                                        visualDensity:
                                            VisualDensity(vertical: -3),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      detailPage(
                                                          title: docs[index]
                                                              ['title'],
                                                          contents: docs[index]
                                                              ['content'],
                                                          hour: docs[index]
                                                                  ['hour']
                                                              .toString(),
                                                          min: docs[index]
                                                                  ['min']
                                                              .toString(),
                                                          worker: docs[index]
                                                                  ['worker']
                                                              .toString(),
                                                          enrollTime:
                                                              formattedDate)));
                                        },
                                        title: Text(docs[index]['title']),
                                        subtitle: Text(
                                          "${docs[index]['hour']} : ${docs[index]['min']} 까지",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                        trailing: IconButton(
                                          onPressed: () {
                                            showModalBottomSheet<void>(
                                              enableDrag: true,
                                              isScrollControlled: true,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  30.0),
                                                          topRight:
                                                              Radius.circular(
                                                                  30.0))),
                                              context: context,
                                              builder: (context) {
                                                return StatefulBuilder(builder:
                                                    (context,
                                                        StateSetter setState) {
                                                  return Container(
                                                    height: 170,
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 20, 0, 0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        SizedBox(
                                                          height: 30,
                                                        ),
                                                        Text(
                                                          "해당 업무를 삭제하시겠습니까?",
                                                          style: TextStyle(
                                                              fontSize: 20),
                                                        ),
                                                        SizedBox(height: 20),
                                                        Row(
                                                          children: [
                                                            SizedBox(width: 30),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          30.0),
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                },
                                                                child: Text(
                                                                  "취소",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .grey),
                                                                ),
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            // SizedBox(
                                                            //     width: 100),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          30.0),
                                                              child:
                                                                  OutlinedButton(
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                  final managerReference = FirebaseFirestore
                                                                      .instance
                                                                      .collection(
                                                                          "관리자")
                                                                      .doc(
                                                                          "관리자1")
                                                                      .collection(
                                                                          "calendar")
                                                                      .doc(
                                                                          formattedDate)
                                                                      .collection(
                                                                          "업무")
                                                                      .doc(docs[index]
                                                                              [
                                                                              'title']
                                                                          .toString())
                                                                      .delete();
                                                                  for (String worker
                                                                      in name) {
                                                                    final workers = FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            "작업자")
                                                                        .doc(
                                                                            worker)
                                                                        .collection(
                                                                            "calendar")
                                                                        .doc(
                                                                            formattedDate)
                                                                        .collection(
                                                                            "오늘의 할 일")
                                                                        .doc(docs?[index]['title']
                                                                            .toString())
                                                                        .delete();
                                                                  }
                                                                },
                                                                child: Text(
                                                                  "삭제",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                              .red[
                                                                          700]),
                                                                ),
                                                              ),
                                                            ),
                                                            SizedBox(width: 30)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  );
                                                });
                                              },
                                            );
                                          },
                                          icon: Icon(Icons.more_horiz_rounded),
                                        ),
                                        leading: Checkbox(
                                            // fillColor: Colors.yellow,
                                            // value: _isChecked1,
                                            value: _isCheck[index],
                                            onChanged: (bool? value) {
                                              setState(() {
                                                _isCheck[index] = value!;
                                              });
                                            }),
                                      );
                                    },
                                    itemCount: docs.length,
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
              Spacer(),
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            visible: true,
            curve: Curves.bounceIn,
            backgroundColor: Color(0xff316a62),
            children: [
              SpeedDialChild(
                  child: const Icon(Icons.notification_add,
                      color: Color(0xff316a62)),
                  label: "공지 올리기",
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13.0),
                  backgroundColor: Colors.white,
                  labelBackgroundColor: Color(0xff316a62),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddNotice()));
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.add_chart,
                    color: Color(0xff316a62),
                  ),
                  label: "업무 추가하기",
                  backgroundColor: Colors.white,
                  labelBackgroundColor: Color(0xff316a62),
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13.0),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddTask()));
                  }),
            ]));
    // bottomNavigationBar: ,
  }
}

class MyStatelessWidget extends StatelessWidget {
  Future<dynamic> showStatefulBuilderDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        int? selectedRadio = 0;
        return AlertDialog(
          content: StatefulBuilder(
            builder: (__, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(3, (int index) {
                  return Radio<int>(
                    value: index,
                    groupValue: selectedRadio,
                    onChanged: (int? value) {
                      setState(() => selectedRadio = value);
                    },
                  );
                }),
              );
            },
          ),
        );
      },
    );
  }

  Future<dynamic> showStatefulWidgetDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (_) {
        return MyStatefulDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'MyStatelessWidget',
          style: Theme.of(context).textTheme.headline5,
        ),
        TextButton(
          child: const Text('StatefulBuilder 사용'),
          onPressed: () => showStatefulBuilderDialog(context),
        ),
        TextButton(
          child: const Text('StatefulWidget 추출'),
          onPressed: () => showStatefulWidgetDialog(context),
        ),
      ],
    );
  }
}

class MyStatefulDialog extends StatefulWidget {
  @override
  State<MyStatefulDialog> createState() => _MyStatefulDialogState();
}

class _MyStatefulDialogState extends State<MyStatefulDialog> {
  int? selectedRadio = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: List<Widget>.generate(3, (int index) {
          return Radio<int>(
            value: index,
            groupValue: selectedRadio,
            onChanged: (int? value) {
              setState(() => selectedRadio = value);
            },
          );
        }),
      ),
    );
  }
}
