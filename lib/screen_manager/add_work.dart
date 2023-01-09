// 성경 //
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/services.dart';
import '../home/home_manager.dart';
import './manager_home.dart';

late List<dynamic> name = <dynamic>["김00", "이00", "박00", "정00", "장00", "임00", "고00", "노00", "한00", "나00"];
late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀", "E팀", "F팀", "G팀", "H팀", "I팀", "J팀"];

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
  bool _isChecked  = false;
  DateTime? selectedDate;
  File? _image;

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
          ),
        ],
      ),
    );
  }
}
