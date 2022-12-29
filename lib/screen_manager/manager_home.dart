import 'package:flutter/material.dart';
import './add_work.dart';
import './add_urgent_alarm.dart';
import './work_detail.dart';
import './alarm_detail.dart';
import '../user/login.dart';

class Manager_home extends StatelessWidget {
  const Manager_home({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '관리자 홈 (임의로)',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: ''),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          children: <Widget> [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddTask())
                );
              },
              child: Text('업무 추가 바로가기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TaskDetails())
                );
              },
              child: Text('업무 상세보기 바로가기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddAlarm())
                );
              },
              child: Text('긴급 알림 추가 바로가기'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AlarmDetails())
                );
              },
              child: Text('긴급 알림 상세보기 바로가기'),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => login()),
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
