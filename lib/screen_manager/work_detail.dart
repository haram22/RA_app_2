// 성경 //
import 'package:flutter/material.dart';
import './manager_home.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '업무 상세보기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'BM Hanna Pro'
      ),
      home: const MyHomePage(title: '3번 작업장 청소'),
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
  DateTime? selectedDate;

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
      body: Column (
        children: <Widget> [
          Expanded(
              child: SingleChildScrollView(
                child: ListBody(
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: [
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
                      ListTile(
                        title: Text('A팀',style: TextStyle(fontSize: 17),),
                        onTap: () {
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 15,top: 15),
                        child: ListTile(
                          title: Text('본사 납품 도정 공정 작업 지시 요청\nAze 12 L-font 10,000 ea 화이트 크림 WC9 도정 작업완료 후 검수팀에게 재요청 금요일까지 완료', style: TextStyle(fontSize: 17)),
                          onTap: () {
                          },
                        ),
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: 3),  // listtile 세로 길이 늘림
                        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                        leading: Column(
                          children: <Widget> [
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
                        visualDensity: VisualDensity(vertical: 3),  // listtile 세로 길이 늘림
                        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                        leading: Column(
                          children: <Widget> [
                            Text('담당자', style: TextStyle(fontSize: 13, color: Colors.grey)),
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
                        leading: Text('등록시간', style: TextStyle(color: Colors.grey)),
                        trailing: Text('2022.12.26(월) 오후 12:17'),
                      ),
                      ListTile(
                        leading: Text('마감일자', style: TextStyle(color: Colors.grey)),
                        trailing: Text('2022.12.26(월) 오후 04:30'),
                      ),
                      ListTile(
                        leading: Text('첨부파일', style: TextStyle(color: Colors.grey)),
                      ),

                    ],
                  ).toList(),
                ),
              ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: ElevatedButton(
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
          ),
        ],
      )
    );
  }
}
