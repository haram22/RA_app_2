import 'package:flutter/material.dart';
import './manager_home.dart';
import '../home/home_manager.dart';

late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀", "E팀", "F팀", "G팀", "H팀", "I팀", "J팀"];


class AddNotice extends StatelessWidget {
  const AddNotice({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '공지추가(관리자)',
      theme: ThemeData(
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
                          title: Text('공지 제목'),
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
                          title: Text('공지 내용'),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                  }
              ),

              ElevatedButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                  }
              )
            ],
          )
        ],
      ),
    );
  }
}
