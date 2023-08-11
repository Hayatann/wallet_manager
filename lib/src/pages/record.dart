import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallet_manager/src/db/consumes.dart';
import 'package:wallet_manager/src/pages/home.dart';
import '../db/db_helper.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends State<RecordPage> {
  List<Consumes> consumesList = [];
  bool isLoading = false;

  // initState()でConsumesの全データを取得
  @override
  void initState() {
    super.initState();
    getConsumesList();
  }

  // Consumesの全データを取得
  Future getConsumesList() async {
    setState(() {
      isLoading = true;
    });
    consumesList = await DbHelper.instance.selectAllConsumes();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          centerTitle: true,
          title: const Text('家計簿', style: TextStyle(color: Colors.white)),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(40),
                    child: Row(
                      children: <Widget>[],
                    ),
                  ),
                ],
              ));
  }
}
