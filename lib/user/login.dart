import 'package:flutter/material.dart';

import '../home/home_manager.dart';
import '../home/home_worker.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

int? _value = 0;

class _loginState extends State<login> {
  List<String> role = ["작업자", "관리자"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 308.0, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'ID',
                hintText: 'ID 번호를 입력해주세요.',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            TextField(
              decoration: InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력해주세요.',
                labelStyle: TextStyle(color: Colors.grey),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 1, color: Colors.black),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.text,
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Row(
                children: [
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      2,
                      (int index) {
                        return ChoiceChip(
                          selectedColor: Colors.black,
                          disabledColor: Colors.grey[700],
                          backgroundColor: Colors.grey[400],
                          selected: _value == index,
                          label: Text(
                            '${role[index]}',
                            style: TextStyle(color: Colors.white),
                          ),
                          onSelected: (bool selected) {
                            setState(() {
                              _value = selected ? index : null;
                              print(index);
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
            SizedBox(
              height: 57,
              width: 277,
              child: OutlinedButton(
                  onPressed: () {
                    if (_value == 0) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home_w();
                      }));
                    } else {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Home_m();
                      }));
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.black),
                  ),
                  style: OutlinedButton.styleFrom()),
            )
          ],
        ),
      ),
    );
  }
}

// 하람 //