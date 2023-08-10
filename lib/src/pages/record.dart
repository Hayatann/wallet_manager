import 'package:flutter/material.dart';

class RecordPage extends StatelessWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          centerTitle: true,
          title: const Text('家計簿', style: TextStyle(color: Colors.white)),
        ),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.all(40),
              child: Row(
                children: <Widget>[
                  Text("title", style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Text("¥price", style: TextStyle(fontSize: 20)),
                  Spacer(),
                  Text("Genre", style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ));
  }
}
