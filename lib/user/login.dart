import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:ra_application/main.dart';

import '../home/home_manager.dart';
import '../main.dart';
import '../home/home_worker.dart';
import '../home/streamTest.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

int? _value = 0;

class _loginState extends State<login> {
  List<String> role = ["작업자", "관리자"];
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffe8c869),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.only(top: 308.0, left: 20, right: 20),
        child: Column(
          children: [
            TextField(
              controller: idController,
              decoration: const InputDecoration(
                labelText: 'ID',
                hintText: 'ID 번호를 입력해주세요.',
                labelStyle: TextStyle(fontSize: 20, color: Color(0xff316a62)),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2.5, color: Color(0xff316a62)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2.5, color: Color(0xff316a62)),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),
            TextField(
              controller: pwController,
              decoration: const InputDecoration(
                labelText: '비밀번호',
                hintText: '비밀번호를 입력해주세요.',
                labelStyle: TextStyle(color: Color(0xff316a62), fontSize: 20),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2.5, color: Color(0xff316a62)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(width: 2.5, color: Color(0xff316a62)),
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
                    spacing: 10.0,
                    children: List<Widget>.generate(
                      2,
                          (int index) {
                        return ChoiceChip(
                          shape: RoundedRectangleBorder(
                            //모서리를 둥글게
                              borderRadius: BorderRadius.circular(20),
                              side: BorderSide(
                                  width: 1.5, color: Color(0xff6A6A6A))),
                          selectedColor: Color(0xff6A6A6A),
                          backgroundColor: Color(0xffe8c869),
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
            Spacer(),
            Spacer(),
            SizedBox(
              height: 60,
              width: 250,
              child: ElevatedButton(
                  onPressed: () async {
/*
              height: 57,
              width: 277,
              child: OutlinedButton(
                  onPressed: () async {
                  */

                    FocusScope.of(context).unfocus();
                    String id = idController.text.trim();
                    String pw = pwController.text.trim();
                    final token1 = await FirebaseMessaging.instance.getToken();

                    if (id.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("아이디를 입력해주세요"),
                      ));
                    } else if (pw.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("비밀번호를 입력해주세요"),
                      ));
                    } else {
                      if(_value == 0) {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("작업자")
                            .where('id', isEqualTo: id)
                            .get();
                        try {
                          if (pw == snap.docs[0]['pw']) {
                            final tokenReference = FirebaseFirestore.instance
                                .collection("작업자")
                                .doc("김00");
                            tokenReference.update({
                              "token": '${token1}'
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  // return streamT();
                                  return Home_w(name: snap.docs[0]['name']);
                                }));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("비밀번호가 일치하지 않습니다"),
                            ));
                          }
                        } catch (e) {
                          String error = " ";
                          if (e.toString() ==
                              "RangeError (index): Invalid value: Valid value range is empty: 0") {
                            setState(() {
                              error = "일치하는 아이디가 존재하지 않습니다";
                            });
                          } else {
                            setState(() {
                              error = "Error occured";
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(error),
                          ));
                        }
                      }
                      else {
                        QuerySnapshot snap = await FirebaseFirestore.instance
                            .collection("관리자")
                            .where('id', isEqualTo: id)
                            .get();
                        try {
                          if (pw == snap.docs[0]['pw']) {
                            final tokenReference = FirebaseFirestore.instance
                                .collection("관리자")
                                .doc("관리자1");
                            tokenReference.update({
                              "token": '${token1}'
                            });
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                                  return Home_m();
                                }));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("비밀번호가 일치하지 않습니다"),
                            ));
                          }
                        }  catch (e) {
                          String error = " ";
                          if (e.toString() ==
                              "RangeError (index): Invalid value: Valid value range is empty: 0") {
                            setState(() {
                              error = "일치하는 아이디가 존재하지 않습니다";
                            });
                          } else {
                            setState(() {
                              error = "Error occured";
                            });
                          }

                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(error),
                          ));
                        }
                      }
                    }
                  },
                  child: Text(
                    "Login",
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xff316a62),
                    shape: RoundedRectangleBorder(
                      //모서리를 둥글게
                        borderRadius: BorderRadius.circular(20)),
                  )),
            ),
            Spacer()
          ],
        ),
      ),
    );
  }
}

// 하람 //