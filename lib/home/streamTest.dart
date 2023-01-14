import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class streamT extends StatefulWidget {
  const streamT({super.key});

  @override
  State<streamT> createState() => _streamTState();
}

class _streamTState extends State<streamT> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Stream builder")),
      body: Column(
        children: [
          Text("dsds"),
          Container(
            height: 100,
            width: 100,
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('first').snapshots(),
              builder: (BuildContext,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      child: Text(docs[index]['test']),
                    );
                  },
                  itemCount: docs.length,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
