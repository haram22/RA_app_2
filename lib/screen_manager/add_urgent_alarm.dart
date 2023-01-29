import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

late List<dynamic> name = <dynamic>["kim00", "lee00", "park00", "jung00"];
late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀"];
late List<String> selectedTeam = <String>[];
late List<String> selectedName = <String>[];

late List<bool> isCheckedTeam = <bool>[false, false, false, false];
late List<bool> isCheckedName = <bool>[false, false, false, false];

class AddAlarm extends StatelessWidget {
  const AddAlarm({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '긴급알림추가(관리자)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '긴급 알림 추가'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String teamName, content, worker, deadlineDate, deadlineTime;
  // bool _isChecked  = false;
  DateTime? selectedDate;
  final inputController1 = TextEditingController();
  final inputController2 = TextEditingController();
  final inputController3 = TextEditingController();

  @override
  initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: ListBody(
              children: ListTile.divideTiles(context: context, tiles: [
                ListTile(
                  title: Text('부서'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25),
                                topStart: Radius.circular(25),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('부서'),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: team.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: const CircleAvatar(
                                                backgroundColor: Colors.white,
                                                backgroundImage: AssetImage(
                                                    'assets/images/team.png'),
                                              ),
                                              title: Text('${team[index]}'),
                                              trailing: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.redAccent,
                                                value: isCheckedTeam[index],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedTeam[index] =
                                                        value!;
                                                    if (isCheckedTeam[index]) {
                                                      selectedTeam
                                                          .add(team[index]);
                                                    } else
                                                      selectedTeam
                                                          .remove(team[index]);
                                                  });
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton(
                                          child: const Text('취소'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        ElevatedButton(
                                          child: const Text('선택'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ),
                ListTile(
                  title: Text('알림 구분: '),
                  trailing: Container(
                    width: 280.0,
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          // flex: 3,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String? newValue) {
                              content = newValue!;
                              print(content);
                            },
                            controller: inputController1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('알림 명칭: '),
                  trailing: Container(
                    width: 280.0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: TextField(
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onChanged: (String? newValue) {
                              content = newValue!;
                              print(content);
                            },
                            controller: inputController2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ListTile(
                  title: Text('긴급 공지 내용'),
                  onTap: () {},
                  // trailing: Icon(Icons.arrow_forward_ios),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String? newValue) {
                    content = newValue!;
                    print(content);
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter some text';
                    }
                  },
                  controller: inputController3,
                  minLines: 1,
                  maxLines: 5,
                ),
                ListTile(
                  title: Text('담당자'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25),
                                topStart: Radius.circular(25),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('담당자'),
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          scrollDirection: Axis.vertical,
                                          itemCount: name.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              leading: const CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    'assets/images/user.png'),
                                              ),
                                              title: Text('${name[index]}'),
                                              trailing: Checkbox(
                                                checkColor: Colors.white,
                                                activeColor: Colors.redAccent,
                                                value: isCheckedName[index],
                                                onChanged: (bool? value) {
                                                  setState(() {
                                                    isCheckedName[index] =
                                                        value!;
                                                    if (isCheckedName[index]) {
                                                      selectedName
                                                          .add(name[index]);
                                                    } else
                                                      selectedName
                                                          .remove(name[index]);
                                                  });
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton(
                                          child: const Text('취소'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        ElevatedButton(
                                          child: const Text('선택'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                ),
                ListTile(
                  title: Text('마감일자'),
                  trailing: Wrap(
                    spacing: 25,
                    children: <Widget>[
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  topStart: Radius.circular(25),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('날짜 선택'),
                                      CalendarDatePicker(
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime.now(),
                                        lastDate: DateTime(2100, 12, 31),
                                        onDateChanged: (date) {
                                          setState(() {
                                            selectedDate = date;
                                          });
                                        },
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ElevatedButton(
                                            child: const Text('취소'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          ElevatedButton(
                                            child: const Text('선택'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text('날짜 선택'),
                      ),
                      TextButton(
                        onPressed: () {
                          showModalBottomSheet<void>(
                              isScrollControlled: true,
                              context: context,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadiusDirectional.only(
                                  topEnd: Radius.circular(25),
                                  topStart: Radius.circular(25),
                                ),
                              ),
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      const Text('시간 선택'),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ElevatedButton(
                                            child: const Text('취소'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          ElevatedButton(
                                            child: const Text('선택'),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                        child: const Text('시간 선택'),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: Text('첨부파일'),
                  trailing: IconButton(
                      onPressed: () {
                        showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.only(
                                topEnd: Radius.circular(25),
                                topStart: Radius.circular(25),
                              ),
                            ),
                            builder: (BuildContext context) {
                              return Container(
                                padding: const EdgeInsets.all(20),
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    const Text('첨부 파일'),
                                    MaterialButton(
                                      onPressed: () {},
                                      child: Text('파일 선택'),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton(
                                          child: const Text('취소'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        ElevatedButton(
                                          child: const Text('선택'),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            });
                      },
                      icon: Icon(Icons.arrow_forward_ios)),
                )
              ]).toList(),
            ),
          )),

          // const SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(child: Text('취소'), onPressed: () {}),
              ElevatedButton(
                  child: Text('확인'),
                  onPressed: () {
                    final managerReference = FirebaseFirestore.instance
                        .collection("관리자")
                        .doc("관리자1");
                    final calendarReference = managerReference
                        .collection("calendar")
                        .doc("2023-01-05 00:00:00.000");
                    final urgentTempReference =
                        calendarReference.collection("공지").doc("긴급");
                    final urgentReference = urgentTempReference
                        .collection("긴급 바로가기")
                        .doc(inputController2.text);
                    urgentReference.set({
                      "알림 구분": inputController1.text,
                      "알림 명칭": inputController2.text,
                      "content": inputController3.text,
                      "team": FieldValue.arrayUnion(selectedTeam),
                      "worker": FieldValue.arrayUnion(selectedName),
                      "isComplete": "접수",
                    });
                    for (String worker in selectedName) {
                      urgentReference.update({
                        worker: {
                          'isComplete': "접수",
                        }
                      });

                      final workerReference = FirebaseFirestore.instance
                          .collection("worker")
                          .doc(worker);
                      final calReference = workerReference
                          .collection("calendar")
                          .doc("2023-01-05 00:00:00.000");
                      final todayNotice =
                          calReference.collection("오늘의 공지").doc("긴급");
                      final todayUrgent = todayNotice
                          .collection("긴급 바로가기")
                          .doc(inputController2.text);
                      todayUrgent.set({
                        "알림 구분": inputController1.text,
                        "알림 명칭": inputController2.text,
                        "content": inputController3.text,
                        "isComplete": "접수",
                      });
                    }
                    print("selectedTeam: " + selectedTeam.toString());
                    print("selectedName: " + selectedName.toString());
                  })
            ],
          )
        ],
      ),
    );
  }
}
