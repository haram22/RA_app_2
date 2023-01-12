// 성경 //
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../home/home_manager.dart';
import './manager_home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late List<dynamic> name = <dynamic>["김00", "이00", "박00", "정00"];
late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀"];
late List<String> selectedTeam = <String>[];
late List<String> selectedName = <String>[];

late List<bool> isCheckedTeam = <bool>[false, false, false, false];
late List<bool> isCheckedName = <bool>[false, false, false, false];

class AddTask extends StatelessWidget {
  const AddTask({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '업무추가(관리자)',
      theme: ThemeData(
        fontFamily: 'BM Hanna Pro',
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: '업무 추가'),
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
  late String teamName, content, worker, deadlineDate, deadlineTime;
  bool _isChecked  = false;
  DateTime? selectedDate;
  File? _image;
  final inputController1 = TextEditingController();
  final inputController2 = TextEditingController();

  final picker = ImagePicker();
  Future getImage(ImageSource imageSource) async {
    final image = await picker.pickImage(source: imageSource);
    setState(() {
      _image = File(image!.path);
    });
  }
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
                          visualDensity: VisualDensity(vertical: 2),
                          title: Text('부서',style: TextStyle(fontSize: 18),),
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
                                                    value: isCheckedTeam[index],
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isCheckedTeam[index] = value!;
                                                        if(isCheckedTeam[index]) {
                                                          selectedTeam.add(team[index]);
                                                        } else selectedTeam.remove(team[index]);
                                                      });
                                                    },
                                                  ),
                                                );
                                              }
                                          ),
                                        ),
                                        //취소,확인버튼
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 0),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget> [
                                              ElevatedButton(
                                                  style: ElevatedButton.styleFrom(
                                                    primary:Color(0xff316a62),
                                                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                        borderRadius: BorderRadius.circular(15)),
                                                    minimumSize: Size(30, 36),
                                                  ),
                                                  child: const Text('취소',
                                                    style: TextStyle(
                                                      fontSize: 17,
                                                      color: Color(0xffffffff),
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  }),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary:Color(0xff316a62),
                                                  shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                      borderRadius: BorderRadius.circular(15)),
                                                  minimumSize: Size(30, 36),

                                                ),
                                                child: const Text('저장',
                                                  style: TextStyle(
                                                    fontSize: 17,
                                                    color: Color(0xffffffff),
                                                  ),
                                                  textAlign: TextAlign.center,
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },)
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }
                            );
                          }, icon: Icon(Icons.arrow_forward_ios)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 20),
                          child: SizedBox(
                            height: 110,
                            child: ListTile(
                              title: Text('업무 제목',style: TextStyle(fontSize: 18),),
                              subtitle: new Container(
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
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), // trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(top:10,bottom: 20),
                          child: SizedBox(
                            child: ListTile(
                              title: Text('업무 내용',style: TextStyle(fontSize: 18),),
                              subtitle: new Container(
                                padding: const EdgeInsets.only(top:20,bottom: 10),
                                width: 280.0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: <Widget>[
                                    Expanded(
                                      flex: 3,
                                      child: TextField(
                                        minLines: 3,
                                        maxLines: 10,
                                        style: TextStyle(fontSize: 15),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ), // trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),

/*
                        TextFormField(
                          decoration: InputDecoration(
                            // labelText: '업무 내용',
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (String? newValue) {
                            content = newValue!;
                            print(content);
                          },
                          validator: (value) {
                            if(value!.isEmpty) {
                              return 'Please enter some text';
                            }
                          },
                          controller: inputController1,
                          minLines: 1,
                          maxLines: 5,*/

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
                                        const Text('담당자',style: TextStyle(fontSize: 20,color:  Color(0xff316a62)),),
                                        Expanded(
                                          child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis.vertical,
                                              itemCount: name.length,
                                              itemBuilder: (context, index) {
                                                return ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundColor: Colors.white,
                                                    backgroundImage: AssetImage('assets/profile.png'),
                                                  ),

                                                  title: Text('${name[index]}'),
                                                  trailing: Checkbox(
                                                    checkColor: Colors.white,
                                                    activeColor: Colors.redAccent,
                                                    value: isCheckedName[index],
                                                    onChanged: (bool? value) {
                                                      setState(() {
                                                        isCheckedName[index] = value!;
                                                        if(isCheckedName[index]) {
                                                          selectedName.add(name[index]);
                                                        } else selectedName.remove(name[index]);
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
                                          height: MediaQuery.of(context).size.height*0.65,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              const Text('날짜 선택',style: TextStyle(fontSize:20,color: Color(0xff316a62) ),),
                                              SizedBox(height: 20,),
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

                                              Spacer(),
                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget> [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary:Color(0xff316a62),
                                                          shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                              borderRadius: BorderRadius.circular(15)),
                                                          minimumSize: Size(30, 36),
                                                        ),
                                                        child: const Text('취소',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(0xffffffff),
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary:Color(0xff316a62),
                                                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                            borderRadius: BorderRadius.circular(15)),
                                                        minimumSize: Size(30, 36),

                                                      ),
                                                      child: const Text('저장',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0xffffffff),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);;
                                                      },)
                                                  ],
                                                ),
/*
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget> [
                                                  ElevatedButton(
                                                    child: const Text('취소'),
                                                    onPressed: () => Navigator.pop(context),
                                                  ),
                                                  ElevatedButton(
                                                    child: const Text('선택'),
                                                    // onPressed: () => Navigator.pop(context),
                                                    onPressed: () {

                                                    },
                                                  ),
                                                ],*/

                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: const Text('날짜 선택',style: TextStyle(color: Color(0xff316a62) )),
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
                                              const Text('시간 선택',style: TextStyle(fontSize: 20,color:  Color(0xff316a62)),),
                                              Spacer(),

                                              Padding(
                                                padding: const EdgeInsets.only(bottom: 0),
                                                child: Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children: <Widget> [
                                                    ElevatedButton(
                                                        style: ElevatedButton.styleFrom(
                                                          primary:Color(0xff316a62),
                                                          shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                              borderRadius: BorderRadius.circular(15)),
                                                          minimumSize: Size(30, 36),
                                                        ),
                                                        child: const Text('취소',
                                                          style: TextStyle(
                                                            fontSize: 17,
                                                            color: Color(0xffffffff),
                                                          ),
                                                          textAlign: TextAlign.center,
                                                        ),
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        }),
                                                    ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary:Color(0xff316a62),
                                                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                            borderRadius: BorderRadius.circular(15)),
                                                        minimumSize: Size(30, 36),

                                                      ),
                                                      child: const Text('저장',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0xffffffff),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);;
                                                      },)
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }
                                  );
                                },
                                child: const Text('시간 선택',style: TextStyle(color: Color(0xff316a62) )),
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
                                        height: MediaQuery.of(context).size.height*0.6,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: <Widget>[
                                            const Text('첨부 파일',style: TextStyle(fontSize: 20,color:  Color(0xff316a62)),),
                                            SizedBox(height: 20,),
                                            MaterialButton(
                                              color: Colors.grey,
                                              child: const Text(
                                                  "갤러리 +",
                                                  style: TextStyle(color: Colors.white)
                                              ),
                                              onPressed: () {
                                                // pickImage();
                                                getImage(ImageSource.gallery);
                                              },
                                            ),
                                            MaterialButton(
                                              color: Colors.grey,
                                              child: const Text(
                                                  "카메라 +",
                                                  style: TextStyle(color: Colors.white)
                                              ),
                                              onPressed: () {
                                                getImage(ImageSource.camera);
                                              },
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 10),
                                                child: Center(
                                                  child: _image != null ? Image.file(File(_image!.path)) : Text("No image selected"),
                                                )
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding: const EdgeInsets.only(bottom: 20),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: <Widget> [
                                                  ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                        primary:Color(0xff316a62),
                                                        shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                            borderRadius: BorderRadius.circular(15)),
                                                        minimumSize: Size(30, 36),
                                                      ),
                                                      child: const Text('취소',
                                                        style: TextStyle(
                                                          fontSize: 17,
                                                          color: Color(0xffffffff),
                                                        ),
                                                        textAlign: TextAlign.center,
                                                      ),
                                                      onPressed: () {
                                                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                                                      }),
                                                  ElevatedButton(
                                                    style: ElevatedButton.styleFrom(
                                                      primary:Color(0xff316a62),
                                                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                                                          borderRadius: BorderRadius.circular(15)),
                                                      minimumSize: Size(30, 36),

                                                    ),
                                                    child: const Text('업로드',
                                                      style: TextStyle(
                                                        fontSize: 17,
                                                        color: Color(0xffffffff),
                                                      ),
                                                      textAlign: TextAlign.center,
                                                    ),
                                                    onPressed: () {
                                                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                                                    },)
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                );
                              },icon: Icon(Icons.arrow_forward_ios)),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("긴급 ",style: TextStyle(fontSize: 20,color: Color(0xff9B3131),)),
                              Switch(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                },
                                activeColor: Color(0xff9B3131),
                              ),
                            ],
                          ),
                        )
                      ]
                  ).toList(),
                ),
              )
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget> [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary:Color(0xff316a62),
                      shape: RoundedRectangleBorder(	//모서리를 둥글게
                          borderRadius: BorderRadius.circular(15)),
                      minimumSize: Size(30, 36),
                    ),
                    child: const Text('취소',
                      style: TextStyle(
                        fontSize: 17,
                        color: Color(0xffffffff),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                    }),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary:Color(0xff316a62),
                    shape: RoundedRectangleBorder(	//모서리를 둥글게
                        borderRadius: BorderRadius.circular(15)),
                    minimumSize: Size(30, 36),

                  ),
                  child: const Text('저장',
                    style: TextStyle(
                      fontSize: 17,
                      color: Color(0xffffffff),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {

                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
                  },)
              ],
            ),

                  /*  final managerReference = FirebaseFirestore.instance.collection("관리자").doc("관리자1");
                    final calendarReference = managerReference.collection("calendar").doc("2023-01-05 00:00:00.000");
                    final workReference = calendarReference.collection("업무").doc(inputController1.text);
                    workReference.set({
                      "content": inputController1.text,
                      "team": FieldValue.arrayUnion(selectedTeam),
                      "worker": FieldValue.arrayUnion(selectedName),
                      "isComplete": "접수",
                    });
                    for(String worker in selectedName) {
                      workReference.update({worker: {
                        'isComplete': "접수",
                      }});

                      final workerReference = FirebaseFirestore.instance.collection("작업자").doc(worker);
                      final calReference = workerReference.collection("calendar").doc("2023-01-05 00:00:00.000");
                      final todayWork = calReference.collection("오늘의 할 일").doc(inputController1.text);
                      todayWork.set({
                        "content": inputController1.text,
                        "isComplete": "접수",
                      });
                    }
                    print("selectedTeam: " + selectedTeam.toString());
                    print("selectedName: " + selectedName.toString());

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
            */

          ),
        ],
      ),
    );
  }
}
