import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal.shade900,
        title: const Text('家計簿', style: TextStyle(color: Colors.white)),
      ),
      body: const Center(
        child: Text(
          'ホーム',
          style: TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
