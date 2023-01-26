import 'package:flutter/material.dart';
import './manager_home.dart';
import '../home/home_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddNotice extends StatelessWidget {
  const AddNotice({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '공지추가(관리자)',
      theme: ThemeData(
        fontFamily: 'BM Hanna Pro',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '공지 추가'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class _MyHomePageState extends State<MyHomePage> {
  bool _isChecked = false;
  bool isSwitched1 = false;
  DateTime? selectedDate;
  final inputController1 = TextEditingController();
  final inputController2 = TextEditingController();

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
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Color(0xffe8c869),
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: ListBody(
              children: ListTile.divideTiles(context: context, tiles: [
                //공지 제목
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: SizedBox(
                    height: 110,
                    child: ListTile(
                      title: const Text(
                        '공지 제목',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        width: 280.0,
                        height: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextField(
                                minLines: 1,
                                maxLines: 3,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: inputController1,
                              ),
                            ),
                          ],
                        ),
                      ), // trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                //공지 내용
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 20),
                  child: SizedBox(
                    child: ListTile(
                      title: Text(
                        '공지 내용',
                        style: TextStyle(fontSize: 18),
                      ),
                      subtitle: Container(
                        padding: const EdgeInsets.only(top: 20, bottom: 10),
                        width: 280.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: TextField(
                                minLines: 5,
                                maxLines: 10,
                                style: TextStyle(fontSize: 15),
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                ),
                                controller: inputController2,
                              ),
                            ),
                          ],
                        ),
                      ), // trailing: Icon(Icons.arrow_forward_ios),
                    ),
                  ),
                ),
                //긴급 버튼
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '🚨 ',
                        style: TextStyle(fontSize: 17),
                      ),
                      Text("긴급",
                          style: TextStyle(
                            fontSize: 22,
                            color: Color(0xff9B3131),
                          )),
                      Switch(
                        value: isSwitched1,
                        onChanged: (value) {
                          setState(() {
                            isSwitched1 = value;
                          });
                        },
                        activeColor: Color(0xff9B3131),
                      ),
                    ],
                  ),
                )
              ]).toList(),
            ),
          )),

          // const SizedBox(height: 200),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Color(0xff316a62),
                      shape: RoundedRectangleBorder(
                          //모서리를 둥글게
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: Size(30, 36),
                    ),
                    child: const Text(
                      '취소',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home_m()));
                    }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff316a62),
                    shape: RoundedRectangleBorder(
                        //모서리를 둥글게
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(30, 36),
                  ),
                  child: const Text(
                    '저장',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    final managerReference = FirebaseFirestore.instance
                        .collection("관리자")
                        .doc("관리자1");
                    final calendarReference = managerReference
                        .collection("calendar")
                        .doc(formattedDate.toString());
                    final noticeReference = calendarReference
                        .collection("공지")
                        .doc(inputController1.text);
                    noticeReference.set({
                      "isEmergency":
                          isSwitched1 ? true.toString() : false.toString(),
                      "title": inputController1.text,
                      "content": inputController2.text,
                      "isComplete": "접수",
                    });

                    //작업자 컬랙션 내 모든 doc에 문서 올리기 지금은 임의로 한명만 보냄
                    // final workerReference = FirebaseFirestore.instance.collection("작업자").doc('김00');
                    // final calReference = workerReference.collection("calendar").doc("2023-01-12");
                    // final todayNotice = isSwitched1 ? calReference.collection("오늘의 공지").doc("긴급") : calReference.collection("오늘의 공지").doc("일반");
                    // final todayUrgent = isSwitched1 ? todayNotice.collection("긴급 바로가기").doc(inputController1.text) : todayNotice.collection("일반 바로가기").doc(inputController1.text);
                    // todayUrgent.set({
                    //   "공지 제목": inputController1.text,
                    //   "공지 내용": inputController2.text,
                    //   "isComplete": "접수",
                    // });
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Home_m()));
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
