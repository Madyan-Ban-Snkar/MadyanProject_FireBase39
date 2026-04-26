import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'firebase_options.dart';
import 'showResultPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyMainPage());
  }
}

class MyMainPage extends StatefulWidget {
  const MyMainPage({super.key});

  @override
  State<MyMainPage> createState() => _MyMainPageState();
}

class _MyMainPageState extends State<MyMainPage> {

  final TextEditingController _controllername = TextEditingController();

  void _saveUSERData(BuildContext context) {
    if (_controllername.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('notes').add({
        'text': _controllername.text,
        'time': Timestamp.now(),
      });
      _controllername.clear();
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Showresultpage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Enter Data Page" , style: TextStyle(color: Colors.blueGrey),)),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: _controllername,
              decoration: InputDecoration(
                labelText: "Add To",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _saveUSERData(context),
              child: Text("Save data in fire base" , style: TextStyle(color: Colors.cyan),),
            ),SizedBox(height: 380,),
            MaterialButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Showresultpage()),
              ),
              child: Text("Show Assigned Users", style: TextStyle(color: Colors.lightGreen),),
            ),
          ],
        ),
      ),
    );
  }
}
