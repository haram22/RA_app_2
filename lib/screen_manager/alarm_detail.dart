import 'package:flutter/material.dart';
import './manager_home.dart';

class AlarmDetails extends StatelessWidget {
  const AlarmDetails({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '긴급 알림 상세보기',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '긴급 알림'),
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
                        leading: Text('알림 구분', style: TextStyle(color: Colors.grey)),
                        title: Text('설비 시스템'),
                      ),
                      ListTile(
                        leading: Text('알림 명칭', style: TextStyle(color: Colors.grey)),
                        title: Text('냉동 창고 3호'),
                      ),
                      ListTile(
                        leading: Text('알림 메시지', style: TextStyle(color: Colors.grey)),
                        title: Text('온도 상승 경고,원인 확인 및 조치내역을 등록하세요.', style: TextStyle(fontSize: 15)),
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
