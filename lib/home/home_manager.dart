// 하람 //
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Home_m extends StatefulWidget {
  const Home_m({super.key});

  @override
  State<Home_m> createState() => _Home_mState();
}

class _Home_mState extends State<Home_m> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Row(
            children: [
              Icon(
                Icons.notifications,
                color: Colors.red[200],
                size: 30,
              ),
              SizedBox(width: 20)
            ],
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 20, left: 20.0, right: 20),
        child: Column(
          children: [
            SizedBox(
              height: 50,
              width: 400,
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                  side: BorderSide(
                    color: Colors.black,
                  ),
                ),
                elevation: 0,
                child: Row(
                  children: [SizedBox(width: 20), Text("🚨  긴급")],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
