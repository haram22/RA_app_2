// 하람 //
import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

import '../screen_manager/check_detail.dart';
import '../screen_manager/manager_home.dart';
import '../screen_manager/work_detail.dart';
import '../screen_worker/setting_w.dart';

import '../screen_manager/check_detail.dart';
import '../screen_manager/manager_home.dart';
import '../screen_manager/work_detail.dart';
import '../screen_worker/setting_w.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';

import 'package:flutter/material.dart';

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
  List todos = [];
  String input = "";
  DateTime _selectedValue = DateTime.now();

  getData() async {
    var result =
        await FirebaseFirestore.instance.collection('관리자').doc('관리자2').get();
    print(result);
  }

  @override
  void initState() {
    super.initState();
    todos.add("안전모 닦기");
    // getData();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   getData();
  // }

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
                          SizedBox(height: 10),
                          Container(
                            height: 30,
                            // width: 0,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      // 날짜에 현 날짜 data 넣기
                                      '관리자/관리자1/calendar/2023-01-14/공지')
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
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
                                                "✔️ " + docs[index]['content'],
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
                              },
                            ),
                          ),
                          Container(
                            height: 30,
                            // width: 0,
                            child: StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection(
                                      // 날짜에 현 날짜 data 넣기
                                      '관리자/관리자1/calendar/2023-01-14/공지')
                                  .snapshots(),
                              builder: (BuildContext,
                                  AsyncSnapshot<
                                          QuerySnapshot<Map<String, dynamic>>>
                                      snapshot) {
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
                              },
                            ),
                          ),
                          // Container(
                          //   height: 100,
                          //   // width: 0,
                          //   child: StreamBuilder(
                          //     stream: FirebaseFirestore.instance
                          //         .collection(
                          //             // 날짜에 현 날짜 data 넣기
                          //             '관리자/관리자1/calendar/2023-01-14/공지')
                          //         .snapshots(),
                          //     builder: (BuildContext,
                          //         AsyncSnapshot<
                          //                 QuerySnapshot<Map<String, dynamic>>>
                          //             snapshot) {
                          //       final docs = snapshot.data!.docs;
                          //       return ListView.builder(
                          //         itemBuilder: (context, index) {
                          //           return ListTile(
                          //             dense: true,
                          //             visualDensity:
                          //                 VisualDensity(vertical: -4),
                          //             title:
                          //                 Text("✔️ " + docs[index]['content']),
                          //           );
                          //         },
                          //         itemCount: docs.length,
                          //       );
                          //     },
                          //   ),
                          // ),
                          ListTile(
                            dense: true,
                            visualDensity: VisualDensity(vertical: -4),
                            onTap: () {
                              // getData();
                            },
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
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.4,
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          const Text(
                                            '안전모를 꼭 착용하고 작업하시기 바랍니다.',
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Color(0xff316a62)),
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
                                              primary: Color(0xff316a62),
                                              shape: RoundedRectangleBorder(
                                                  //모서리를 둥글게
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              minimumSize: Size(30, 36),
                                            ),
                                            child: const Text(
                                              '확인',
                                              style: TextStyle(
                                                fontSize: 17,
                                                color: Color(0xffffffff),
                                              ),
                                              textAlign: TextAlign.center,
                                            ),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                        ],
                                      ),
                                    );
                                  });
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
                            Container(
                              height: 120,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection(
                                        // 날짜에 현 날짜 data 넣기
                                        '관리자/관리자1/calendar/2023-01-14/업무')
                                    .snapshots(),
                                builder: (BuildContext,
                                    AsyncSnapshot<
                                            QuerySnapshot<Map<String, dynamic>>>
                                        snapshot) {
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
                                                      TaskDetails()));
                                        },
                                        trailing: IconButton(
                                          onPressed: () {},
                                          icon: Icon(Icons.more_horiz_rounded),
                                        ),
                                        leading: Icon(
                                          Icons.check_box_outlined,
                                          color: Colors.grey,
                                        ),
                                        title: Text(docs[index]['content']),
                                        subtitle: Text(
                                          "18:00까지",
                                          style: TextStyle(fontSize: 12),
                                        ),
                                      );
                                    },
                                    itemCount: docs.length,
                                  );
                                },
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
                                                                        "작업자")
                                                                    .doc('김00');
                                                            final calReference =
                                                                workerReference
                                                                    .collection(
                                                                        "calendar")
                                                                    .doc(
                                                                        "2023-01-14");
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
