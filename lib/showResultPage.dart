import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Showresultpage extends StatefulWidget {
  const Showresultpage({super.key});

  @override
  State<Showresultpage> createState() => _ShowresultpageState();
}

class _ShowresultpageState extends State<Showresultpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:Text("Current Users")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('notes')
            .orderBy('time', descending: true)
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['text']),
                leading: Icon(Icons.person),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

