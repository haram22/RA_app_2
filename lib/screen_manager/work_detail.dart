// 성경 //
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd').format(now);

class detailPage extends StatefulWidget {
  const detailPage(
      {super.key,
      required this.title,
      required this.contents,
      required this.enrollTime,
      required this.hour,
      required this.min,
      required this.worker});

  final String title;
  final String contents;
  final String enrollTime;
  final String hour;
  final String min;
  final String worker;
  @override
  State<detailPage> createState() => _detailPageState();
}

class _detailPageState extends State<detailPage> {
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
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffdddd),
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('진행 중'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.amber,
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
                ),
                ElevatedButton(
                  child: const Text('완료'),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xffdddd),
                    onPrimary: Colors.black,
                  ),
                  onPressed: () {},
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
          // ListTile(
          //   visualDensity: VisualDensity(vertical: 3), // listtile 세로 길이 늘림
          //   contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
          //   leading: Text('담당자', style: TextStyle(color: Colors.grey)),
          //   trailing: Text(widget.enrollTime),
          // ),
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
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      )),
      // body: Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: SingleChildScrollView(
      //         child: ListBody(
      //           children: ListTile.divideTiles(
      //             context: context,
      //             tiles: [
      //               ListTile(
      //                 title: Row(
      //                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //                   children: [
      //                     ElevatedButton(
      //                       child: const Text('접수'),
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Color(0xffdddd),
      //                         onPrimary: Colors.black,
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                     ElevatedButton(
      //                       child: const Text('진행 중'),
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Colors.amber,
      //                         onPrimary: Colors.black,
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                     ElevatedButton(
      //                       child: const Text('완료'),
      //                       style: ElevatedButton.styleFrom(
      //                         primary: Color(0xffdddd),
      //                         onPrimary: Colors.black,
      //                       ),
      //                       onPressed: () {},
      //                     ),
      //                   ],
      //                 ),
      //               ),
      //               Padding(
      //                 padding: const EdgeInsets.only(bottom: 15, top: 15),
      //                 child: ListTile(
      //                   title: Text("widget.contents",
      //                       style: TextStyle(fontSize: 17)),
      //                   onTap: () {},
      //                 ),
      //               ),
      //               ListTile(
      //                 visualDensity:
      //                     VisualDensity(vertical: 3), // listtile 세로 길이 늘림
      //                 contentPadding:
      //                     EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
      //                 leading: Column(
      //                   children: <Widget>[
      //                     Text('등록자',
      //                         style:
      //                             TextStyle(fontSize: 13, color: Colors.grey)),
      //                     SizedBox(height: 5),
      //                     CircleAvatar(
      //                       backgroundColor: Color(0xffffffff),
      //                       backgroundImage: AssetImage('assets/profile.png'),
      //                       radius: 20,
      //                     ),
      //                   ],
      //                 ),
      //                 // trailing: Icon(Icons.arrow_forward_ios),
      //               ),
      //               ListTile(
      //                 visualDensity:
      //                     VisualDensity(vertical: 3), // listtile 세로 길이 늘림
      //                 contentPadding:
      //                     EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
      //                 leading: Column(
      //                   children: <Widget>[
      //                     Text('담당자',
      //                         style:
      //                             TextStyle(fontSize: 13, color: Colors.grey)),
      //                     SizedBox(height: 5),
      //                     Row(
      //                       children: [
      //                         Text(
      //                           "widget.people",
      //                           style: TextStyle(fontSize: 17),
      //                         )
      //                       ],
      //                     ),
      //                   ],
      //                 ),
      //                 // trailing: Icon(Icons.arrow_forward_ios),
      //               ),
      //               // ListTile(
      //               //   title: Text("Ds"),
      //               // )
      //             ],
      //           ).toList(),
      //         ),
      //       ),
      //     ),
      //     // ListTile(
      //     //   visualDensity: VisualDensity(vertical: 3), // listtile 세로 길이 늘림
      //     //   contentPadding:
      //     //       EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
      //     //   leading: Text('등록시간', style: TextStyle(color: Colors.grey)),
      //     //   trailing: Text("widget.enrollTime"),
      //     // ),
      //     // ListTile(
      //     //   leading: Text('마감일자', style: TextStyle(color: Colors.grey)),
      //     //   trailing: Text('2022.12.26(월) 오후 04:30'),
      //     // ),
      //     // ListTile(
      //     //   leading: Text('첨부파일', style: TextStyle(color: Colors.grey)),
      //     // ),
      //     // ListTile(
      //     //   leading: Text('첨부파일', style: TextStyle(color: Colors.grey)),
      //     // ),
      //     Padding(
      //       padding: const EdgeInsets.only(bottom: 20),
      //       child: ElevatedButton(
      //         style: ElevatedButton.styleFrom(
      //           primary: Color(0xff316a62),
      //           shape: RoundedRectangleBorder(
      //               //모서리를 둥글게
      //               borderRadius: BorderRadius.circular(15)),
      //           minimumSize: Size(30, 36),
      //         ),
      //         child: const Text(
      //           '확인',
      //           style: TextStyle(
      //             fontSize: 17,
      //             color: Color(0xffffffff),
      //           ),
      //           textAlign: TextAlign.center,
      //         ),
      //         onPressed: () => Navigator.pop(context),
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}
