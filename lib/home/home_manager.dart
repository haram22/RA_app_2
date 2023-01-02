// 하람 //
import 'package:flutter/material.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../screen_manager/add_notice.dart';
import '../screen_manager/add_urgent_alarm.dart';
import '../screen_manager/add_work.dart';
import '../screen_manager/manager_home.dart';
import '../screen_worker/setting_w.dart';

enum SingingCharacter { ten, fifteen, twenty, none }

class Home_m extends StatefulWidget {
  const Home_m({super.key});

  @override
  State<Home_m> createState() => _Home_mState();
}

class _Home_mState extends State<Home_m> {
  SingingCharacter? _character = SingingCharacter.ten;
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
          toolbarHeight: 70,
          elevation: 0,
          backgroundColor: Colors.white70,
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return setting_w();
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
          padding: EdgeInsets.only(top: 20, left: 20.0, right: 20),
          child: Column(
            children: [
              Text(
                "00님! 오늘 하루도 안전한 하루 되세요 :)",
                style: TextStyle(fontSize: 15.5),
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
                height: 180,
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
                height: 230,
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
                                style: TextStyle(
                                    color: Colors.black, fontSize: 17),
                              ),
                              Spacer()
                            ],
                          ),
                          ListTile(
                            trailing: IconButton(
                              onPressed: () {
                                showModalBottomSheet<void>(
                                  enableDrag: true,
                                  isScrollControlled: true,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(30.0),
                                          topRight: Radius.circular(30.0))),
                                  context: context,
                                  builder: (BuildContext context) {
                                    return StatefulBuilder(builder:
                                        (BuildContext context,
                                            StateSetter setState) {
                                      return Container(
                                        height: 300,
                                        padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 0),
                                        child: Column(
                                          children: <Widget>[
                                            RadioListTile(
                                                title: Text("10분 전에 알리기"),
                                                value: SingingCharacter.ten,
                                                groupValue: _character,
                                                onChanged: (value) {
                                                  _character = value;
                                                }),
                                            RadioListTile(
                                                title: Text("15분 전에 알리기"),
                                                value: SingingCharacter.fifteen,
                                                groupValue: _character,
                                                onChanged: (value) {
                                                  _character = value;
                                                }),
                                            RadioListTile(
                                                title: Text("20분 전에 알리기"),
                                                value: SingingCharacter.twenty,
                                                groupValue: _character,
                                                onChanged: (value) {
                                                  _character = value;
                                                }),
                                            RadioListTile(
                                                title: Text("없음"),
                                                value: SingingCharacter.none,
                                                groupValue: _character,
                                                onChanged: (value) {
                                                  _character = value;
                                                }),
                                            OutlinedButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("저장"),
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
            ],
          ),
        ),
        floatingActionButton: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            visible: true,
            curve: Curves.bounceIn,
            backgroundColor: Colors.indigo.shade900,
            children: [
              SpeedDialChild(
                  child:
                      const Icon(Icons.notification_add, color: Colors.indigo),
                  label: "공지 올리기",
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13.0),
                  backgroundColor: Colors.white,
                  labelBackgroundColor: Colors.indigo.shade900,
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddNotice()));
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.add_chart,
                    color: Colors.indigo,
                  ),
                  label: "업무 추가하기",
                  backgroundColor: Colors.white,
                  labelBackgroundColor: Colors.indigo.shade900,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13.0),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddTask()));
                  }),
              SpeedDialChild(
                  child: const Icon(
                    Icons.add_alarm_outlined,
                    color: Colors.red,
                  ),
                  label: "긴급 알림 추가하기",
                  backgroundColor: Colors.white,
                  labelBackgroundColor: Colors.indigo.shade900,
                  labelStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      fontSize: 13.0),
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddAlarm()));
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
