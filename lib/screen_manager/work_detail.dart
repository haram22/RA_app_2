// 성경 //
import 'package:flutter/material.dart';
import './manager_home.dart';

class TaskDetails extends StatelessWidget {
  const TaskDetails({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '업무 상세보기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
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
                        leading: ElevatedButton(
                          child: const Text('진행'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.amber,
                            onPrimary: Colors.black,
                          ),
                          onPressed: () {},
                        ),
                        trailing: Container(
                          width: 100,
                          child: Row(
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: AssetImage('assets/images/user.png'),
                                radius: 17,
                              ),
                              Text('  진행중', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      ListTile(
                        title: Text('A팀'),
                        onTap: () {
                        },
                      ),
                      ListTile(
                        title: Text('본사 납품 도정 공정 작업 지시 요청\nAze 12 L-font 10,000 ea 화이트 크림 WC9 도정 작업완료 후 검수팀에게 재요청 금요일까지 완료', style: TextStyle(fontSize: 15)),
                        onTap: () {
                        },
                      ),
                      ListTile(
                        visualDensity: VisualDensity(vertical: 3),  // listtile 세로 길이 늘림
                        contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 16.0),
                        leading: Column(
                          children: <Widget> [
                            Text('등록자', style: TextStyle(fontSize: 13, color: Colors.grey)),
                            SizedBox(height: 5),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/images/user.png'),
                              radius: 17,
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
                              backgroundImage: AssetImage('assets/images/user.png'),
                              radius: 17,
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
              )
          ),

          // const SizedBox(height: 200),

        ],
      ),

      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Manager_home()),
          );
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xff485ed9)),
            label: '홈',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '진행상황',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '설정',
          ),
        ],
        selectedItemColor: Color(0xff485ed9),
      ),
    );
  }
}
