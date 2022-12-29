import 'package:flutter/material.dart';
import './manager_home.dart';

late List<dynamic> name = <dynamic>["김00", "이00", "박00", "정00", "장00", "임00", "고00", "노00", "한00", "나00"];
late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀", "E팀", "F팀", "G팀", "H팀", "I팀", "J팀"];

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
  bool _isChecked  = false;
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
                          title: Text('부서'),
                          trailing: IconButton(onPressed: () {
                            showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(25),
                                    topStart: Radius.circular(25),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    height: MediaQuery.of(context).size.height*0.7,
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
                                                  leading: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    backgroundImage: AssetImage('assets/images/team.png'),
                                                  ),

                                                  title: Text('${team[index]}'),
                                                  trailing: Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor: Colors.redAccent,
                                                    value: _isChecked,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        _isChecked = value!;
                                                      });
                                                    },
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget> [
                                            ElevatedButton(
                                              child: const Text('취소'),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                            ElevatedButton(
                                              child: const Text('선택'),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          }, icon: Icon(Icons.arrow_forward_ios)),
                        ),
                        ListTile(
                          title: Text('알림 구분: '),
                          trailing: new Container(
                            width: 280.0,
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  // flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text('알림 명칭: '),
                          trailing: new Container(
                            width: 280.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        ListTile(
                          title: Text('업무 내용'),
                          subtitle: new Container(
                            width: 280.0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Expanded(
                                  flex: 3,
                                  child: TextField(
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ), // trailing: Icon(Icons.arrow_forward_ios),
                        ),

                        ListTile(
                          title: Text('담당자'),
                          trailing: IconButton(onPressed: () {
                            showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadiusDirectional.only(
                                    topEnd: Radius.circular(25),
                                    topStart: Radius.circular(25),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  return Container(
                                    padding: const EdgeInsets.all(20),
                                    height: MediaQuery.of(context).size.height*0.7,
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
                                                  leading: CircleAvatar(
                                                    backgroundImage: AssetImage('assets/images/user.png'),
                                                  ),

                                                  title: Text('${name[index]}'),
                                                  trailing: Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor: Colors.redAccent,
                                                    value: _isChecked,
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        _isChecked = value!;
                                                      });
                                                    },
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget> [
                                            ElevatedButton(
                                              child: const Text('취소'),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                            ElevatedButton(
                                              child: const Text('선택'),
                                              onPressed: () => Navigator.pop(context),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          }, icon: Icon(Icons.arrow_forward_ios)),
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
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(25),
                                          topStart: Radius.circular(25),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: const EdgeInsets.all(20),
                                          height: MediaQuery.of(context).size.height*0.7,
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
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget> [
                                                  ElevatedButton(
                                                    child: const Text('취소'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text('선택'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: const Text('날짜 선택'),
                              ),
                              TextButton(
                                onPressed: () {
                                  showModalBottomSheet<void>(
                                      isScrollControlled: true,
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.only(
                                          topEnd: Radius.circular(25),
                                          topStart: Radius.circular(25),
                                        ),
                                      ),
                                      builder: (BuildContext context) {
                                        return Container(
                                          padding: const EdgeInsets.all(20),
                                          height: MediaQuery.of(context).size.height*0.7,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('시간 선택'),

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget> [
                                                  ElevatedButton(
                                                    child: const Text('취소'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text('선택'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
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
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadiusDirectional.only(
                                        topEnd: Radius.circular(25),
                                        topStart: Radius.circular(25),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return Container(
                                        padding: const EdgeInsets.all(20),
                                        height: MediaQuery.of(context).size.height*0.7,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('첨부 파일'),
                                            MaterialButton (
                                              onPressed: () {


                                              },
                                              child: Text('파일 선택'),
                                            ),

                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children: <Widget> [
                                                ElevatedButton(
                                                  child: const Text('취소'),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                                ElevatedButton(
                                                  child: const Text('선택'),
                                                  onPressed: () => Navigator.pop(context),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },icon: Icon(Icons.arrow_forward_ios)),
                        )
                      ]
                  ).toList(),
                ),
              )
          ),

          // const SizedBox(height: 200),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                  child: Text('취소'),
                  onPressed: () {

                  }
              ),

              ElevatedButton(
                  child: Text('확인'),
                  onPressed: () {

                  }
              )
            ],
          )
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
