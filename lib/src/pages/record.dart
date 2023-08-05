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
      body: const Center(
        child: Text(
          '記録',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
