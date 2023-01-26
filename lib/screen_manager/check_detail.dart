// import 'package:flutter/material.dart';

// import '../home/home_manager.dart';

// late List<dynamic> team = <dynamic>["A팀", "B팀", "C팀", "D팀", "E팀", "F팀", "G팀", "H팀", "I팀", "J팀"];


// class CheckTast extends StatelessWidget {
//   const CheckTast({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '진행사항 확인',
//       theme: ThemeData(
//         fontFamily: 'BM Hanna Pro',
//         primarySwatch: Colors.blue,
//       ),
//       home: const MyHomePage(title: '진행사항 확인'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;


//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   bool _isChecked  = false;
//   bool isSwitched1 = false;
//   DateTime? selectedDate;

//   @override
//   initState() {
//     super.initState();
//     selectedDate = DateTime.now();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         toolbarHeight: 70,
//         elevation: 0,
//         backgroundColor: Color(0xffe8c869),
//         centerTitle: true,
//         title: Text(widget.title),
//       ),
//       body: Column (
//         children: <Widget> [
//           Expanded(
//               child: SingleChildScrollView(
//                 child: ListBody(
//                   children: ListTile.divideTiles(
//                       context: context,
//                       tiles: [
//                         //부서 선택
//                         ListTile(
//                           visualDensity: VisualDensity(vertical: 4),
//                           title: Text('부서',style: TextStyle(fontSize: 18),),
//                           trailing: IconButton(onPressed: () {
//                             showModalBottomSheet<void>(
//                                 isScrollControlled: true,
//                                 context: context,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadiusDirectional.only(
//                                     topEnd: Radius.circular(25),
//                                     topStart: Radius.circular(25),
//                                   ),
//                                 ),
//                                 builder: (BuildContext context) {
//                                   return Container(
//                                     padding: const EdgeInsets.all(20),
//                                     height: MediaQuery.of(context).size.height*0.7,
//                                     child: Column(
//                                       mainAxisSize: MainAxisSize.min,
//                                       children: <Widget>[
//                                         const Text('부서'),
//                                         Expanded(
//                                           child: ListView.builder(
//                                               shrinkWrap: true,
//                                               scrollDirection: Axis.vertical,
//                                               itemCount: team.length,
//                                               itemBuilder: (context, index) {
//                                                 return ListTile(
//                                                   leading: CircleAvatar(
//                                                     backgroundColor: Colors.white,
//                                                     backgroundImage: AssetImage('assets/images/team.png'),
//                                                   ),

//                                                   title: Text('${team[index]}'),
//                                                   trailing: Checkbox(
//                                                     checkColor: Colors.white,
//                                                     activeColor: Colors.redAccent,
//                                                     value: _isChecked,
//                                                     onChanged: (bool? value) {
//                                                       setState(() {
//                                                         _isChecked = value!;
//                                                       });
//                                                     },
//                                                   ),
//                                                 );
//                                               }
//                                           ),
//                                         ),
//                                         //취소,확인버튼
//                                         Padding(
//                                           padding: const EdgeInsets.only(bottom: 0),
//                                           child: Row(
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             children: <Widget> [
//                                               ElevatedButton(
//                                                   style: ElevatedButton.styleFrom(
//                                                     primary:Color(0xff316a62),
//                                                     shape: RoundedRectangleBorder(	//모서리를 둥글게
//                                                         borderRadius: BorderRadius.circular(15)),
//                                                     minimumSize: Size(30, 36),
//                                                   ),
//                                                   child: const Text('취소',
//                                                     style: TextStyle(
//                                                       fontSize: 17,
//                                                       color: Color(0xffffffff),
//                                                     ),
//                                                     textAlign: TextAlign.center,
//                                                   ),
//                                                   onPressed: () {
//                                                     Navigator.pop(context);
//                                                   }),
//                                               ElevatedButton(
//                                                 style: ElevatedButton.styleFrom(
//                                                   primary:Color(0xff316a62),
//                                                   shape: RoundedRectangleBorder(	//모서리를 둥글게
//                                                       borderRadius: BorderRadius.circular(15)),
//                                                   minimumSize: Size(30, 36),

//                                                 ),
//                                                 child: const Text('저장',
//                                                   style: TextStyle(
//                                                     fontSize: 17,
//                                                     color: Color(0xffffffff),
//                                                   ),
//                                                   textAlign: TextAlign.center,
//                                                 ),
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },)
//                                             ],
//                                           ),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 }
//                             );
//                           }, icon: Icon(Icons.arrow_forward_ios)),
//                         ),
//                         //공지 제목
//                         Padding(
//                           padding: const EdgeInsets.only(top:10,bottom: 20),
//                           child: SizedBox(
//                             height: 110,
//                             child: ListTile(
//                               title: Text('공지 제목',style: TextStyle(fontSize: 18),),
//                               subtitle: new Container(
//                                 padding: const EdgeInsets.only(bottom: 10),
//                                 width: 280.0,
//                                 height: 170,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: <Widget>[
//                                     Expanded(
//                                       flex: 3,
//                                       child: TextField(
//                                         minLines: 1,
//                                         maxLines: 3,
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ), // trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                         ),
//                         //공지 내용
//                         Padding(
//                           padding: const EdgeInsets.only(top:10,bottom: 20),
//                           child: SizedBox(
//                             child: ListTile(
//                               title: Text('공지 내용',style: TextStyle(fontSize: 18),),
//                               subtitle: new Container(
//                                 padding: const EdgeInsets.only(top:20,bottom: 10),
//                                 width: 280.0,
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: <Widget>[
//                                     Expanded(
//                                       flex: 3,
//                                       child: TextField(
//                                         minLines: 5,
//                                         maxLines: 10,
//                                         style: TextStyle(fontSize: 15),
//                                         decoration: InputDecoration(
//                                           border: OutlineInputBorder(),
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ), // trailing: Icon(Icons.arrow_forward_ios),
//                             ),
//                           ),
//                         ),
//                         //긴급 버튼
//                         Padding(
//                           padding: const EdgeInsets.only(top: 50.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text('🚨 ',style: TextStyle(fontSize: 17),),
//                               Text("긴급",style: TextStyle(fontSize: 22,color: Color(0xff9B3131),)),
//                               Switch(
//                                 value: isSwitched1,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     isSwitched1 = value;
//                                   });
//                                 },
//                                 activeColor: Color(0xff9B3131),
//                               ),
//                             ],
//                           ),
//                         )
//                       ]
//                   ).toList(),
//                 ),
//               )
//           ),

//           // const SizedBox(height: 200),
//           Padding(
//             padding: const EdgeInsets.only(bottom: 20),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: <Widget> [
//                 ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       primary:Color(0xff316a62),
//                       shape: RoundedRectangleBorder(	//모서리를 둥글게
//                           borderRadius: BorderRadius.circular(15)),
//                       minimumSize: Size(30, 36),
//                     ),
//                     child: const Text('취소',
//                       style: TextStyle(
//                         fontSize: 17,
//                         color: Color(0xffffffff),
//                       ),
//                       textAlign: TextAlign.center,
//                     ),
//                     onPressed: () {
//                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
//                     }),
//                 ElevatedButton(
//                   style: ElevatedButton.styleFrom(
//                     primary:Color(0xff316a62),
//                     shape: RoundedRectangleBorder(	//모서리를 둥글게
//                         borderRadius: BorderRadius.circular(15)),
//                     minimumSize: Size(30, 36),

//                   ),
//                   child: const Text('저장',
//                     style: TextStyle(
//                       fontSize: 17,
//                       color: Color(0xffffffff),
//                     ),
//                     textAlign: TextAlign.center,
//                   ),
//                   onPressed: () {
//                     Navigator.push(context, MaterialPageRoute(builder: (context)=>Home_m()));
//                   },)
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
