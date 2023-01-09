import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';

class home_worker extends StatefulWidget {
  const home_worker({super.key});

  @override
  State<home_worker> createState() => _home_workerState();
}

class _home_workerState extends State<home_worker> {
  DatePickerController _controller = DatePickerController();
  DateTime _dateTime = DateTime.now();

  DateTime _selectedValue = DateTime.now();
  List todos = [];
  String input = "";

  @override
  void initState() {
    super.initState();
    todos.add("안전모 닦기");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        toolbarHeight: 70,
        elevation: 0,
        backgroundColor: Colors.white70,
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset('assets/profile.png', width: 50),
              SizedBox(width: 10)
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
          physics: ScrollPhysics(),
          child: Column(
            children: [
              Container(
                child: DatePicker(
                  DateTime.now(),
                  // width: 60,
                  height: 80,
                  controller: _controller,
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  inactiveDates: [
                    // DateTime.now().add(Duration(days: 3)),
                    // DateTime.now().add(Duration(days: 4)),
                    // DateTime.now().add(Duration(days: 7))
                  ],

                  onDateChange: (date) {
                    // New date selected
                    setState(() {
                      _selectedValue = date;
                      print("❗️❗️selectedDate: ${_selectedValue}");
                    });
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                              title: Text("Add Todolist"),
                              content: TextField(
                                onChanged: (String value) {
                                  input = value;
                                },
                              ),
                              actions: <Widget>[
                                TextButton(
                                    onPressed: () {
                                      setState(() {
                                        todos.add(input);
                                      });
                                      final WReference = FirebaseFirestore
                                          .instance
                                          .collection("작업자")
                                          .doc("작업자1");
                                      final calendarReference =
                                          WReference.collection("calendar")
                                              .doc("2023-01-05 00:00:00.000");
                                      final todomaker = calendarReference
                                          .collection("오늘의 할 일")
                                          .doc(input);

                                      todomaker.update({
                                        '할 일': '{input}',
                                      });
                                      // calendarReference.set({"할 일1": input});

                                      Navigator.of(context)
                                          .pop(); // input 입력 후 창 닫히도록
                                    },
                                    child: Text("Add"))
                              ]);
                        });
                  },
                  icon: Icon(Icons.add)),
              Container(
                child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: todos.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Dismissible(
                          // 삭제 버튼 및 기능 추가
                          key: Key(todos[index]),
                          child: Card(
                              elevation: 0.5,
                              margin: EdgeInsets.all(8),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: ListTile(
                                title: Text(todos[index]),
                                trailing: IconButton(
                                    icon: Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        todos.removeAt(index);
                                      });
                                    }),
                              )));
                    }),
              ),
            ],
          )),
    );
  }
}
