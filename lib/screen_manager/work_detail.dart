// 성경 //
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);
// late List<dynamic> name = <dynamic>["kim00", "lee00", "park00", "jung00"];

class detailPage extends StatefulWidget {
  const detailPage({
    super.key,
    required this.title,
    required this.contents,
    required this.enrollTime,
    required this.hour,
    required this.min,
    required this.worker,
    // required this.name
  });

  final String title;
  final String contents;
  final String enrollTime;
  final String hour;
  final String min;
  final String worker;
  // final String name;
  @override
  State<detailPage> createState() => _detailPageState();
}

// late bool selected1 = false;
// late bool selected2 = true;
// late bool selected3 = false;
late int selected = 2;

class _detailPageState extends State<detailPage> {
  late bool selected1 = false;
  late bool selected2 = true;
  late bool selected3 = false;
  late List<String> selectedName = <String>[widget.worker];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Color(0xffe8c869),
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: const Text('접수'),
                  onPressed: () {
                    setState(() {
                      selected = 1;
                      // selected1 = true;
                      // selected2 = false;
                      // selected3 = false;
                      print("접수 ${selected}");
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selected == 1 ? Colors.amber : Color(0xffdddd),
                    onPrimary: Colors.black,
                  ),
                ),
                ElevatedButton(
                  child: const Text('진행 중'),
                  onPressed: () {
                    selected = 2;
                    // selected2 = true;
                    // selected1 = false;
                    // selected3 = false;
                    print("진행 중 ${selected}");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selected == 2 ? Colors.amber : Color(0xffdddd),
                    onPrimary: Colors.black,
                  ),
                ),
                ElevatedButton(
                  child: const Text('완료'),
                  onPressed: () {
                    selected = 3;
                    // selected3 = true;
                    // selected2 = false;
                    // selected1 = false;
                    print("완료 ${selected}");
                  },
                  style: ElevatedButton.styleFrom(
                    primary: selected == 3 ? Colors.amber : Color(0xffdddd),
                    onPrimary: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 15, top: 15),
            child: ListTile(
              title: Text(widget.contents, style: TextStyle(fontSize: 17)),
              onTap: () {},
            ),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: 3), // listtile 세로 길이 늘림
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
            leading: Column(
              children: [
                Text('등록자', style: TextStyle(fontSize: 13, color: Colors.grey)),
                SizedBox(height: 5),
                CircleAvatar(
                  backgroundColor: Color(0xffffffff),
                  backgroundImage: AssetImage('assets/profile.png'),
                  radius: 20,
                ),
              ],
            ),
            // trailing: Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: 3), // listtile 세로 길이 늘림
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
            leading:
                Text('담당자', style: TextStyle(fontSize: 13, color: Colors.grey)),
            trailing: Text(widget.worker),
          ),
          ListTile(
            visualDensity: VisualDensity(vertical: 3), // listtile 세로 길이 늘림
            contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
            leading: Text('등록일자', style: TextStyle(color: Colors.grey)),
            trailing: Text(widget.enrollTime),
          ),
          ListTile(
            leading: Text('마감일자', style: TextStyle(color: Colors.grey)),
            trailing:
                Text('${widget.enrollTime}   ${widget.hour} : ${widget.min}'),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color(0xff316a62),
                shape: RoundedRectangleBorder(
                    //모서리를 둥글게
                    borderRadius: BorderRadius.circular(15)),
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
              onPressed: () {
                Navigator.pop(context);
                final managerReference = FirebaseFirestore.instance
                    .collection("manager")
                    .doc("manager1");
                final calendarReference = managerReference
                    .collection("calendar")
                    .doc(formattedDate.toString());
                final MworkReference =
                    calendarReference.collection("task").doc(widget.title);
                MworkReference.update({
                  "isComplete": selected == 1
                      ? "접수"
                      : selected == 2
                          ? "진행 중"
                          : selected == 3
                              ? "완료"
                              : "null",
                });
              },
            ),
          ),
        ],
      )),
    );
  }
}
