import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String _consumeTitle = ""; // 支出のタイトル
  String _consumeGenre = ""; // 支出のジャンル
  String _consumePrice = ""; // 支出の金額

  // 支出のタイトルを更新する
  void handleConsumeTitle(String e) {
    setState(() {
      _consumeTitle = e;
    });
  }

  // 支出のジャンルを更新する
  void handleConsumeGenre(String e) {
    setState(() {
      _consumeGenre = e;
    });
  }

  // 支出の金額を更新する
  void handleConsumePrice(String e) {
    setState(() {
      _consumePrice = e;
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
        body: Container(
            padding: const EdgeInsets.only(
                left: 150, right: 150, top: 20, bottom: 20),
            child: Center(
                child:
                    Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(children: <Widget>[
                  Text(
                    _consumeTitle,
                    style: TextStyle(
                      color: Colors.teal.shade900,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextField(
                    enabled: true,
                    decoration: const InputDecoration(
                        floatingLabelAlignment: FloatingLabelAlignment.center,
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        labelStyle: TextStyle(fontSize: 30),
                        labelText: "支出のタイトル",
                        hintText: "例: コンビニ弁当",
                        border: OutlineInputBorder()),
                    onChanged: handleConsumeTitle,
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      _consumeGenre,
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      enabled: true,
                      decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 30),
                          labelText: "支出のタイトル",
                          hintText: "例: 食費",
                          border: OutlineInputBorder()),
                      onChanged: handleConsumeGenre,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      _consumePrice.toString(),
                      style: TextStyle(
                        color: Colors.teal.shade900,
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextField(
                      enabled: true,
                      decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 30),
                          labelText: "支出額",
                          hintText: "例: 1000",
                          border: OutlineInputBorder()),
                      keyboardType: TextInputType.number,
                      // int型の範囲にするために、9桁までに制限する
                      // 数字以外の入力を禁止する
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(9)
                      ],
                      onChanged: handleConsumePrice,
                    ),
                  ],
                ),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        fixedSize: const Size(200, 50),
                        backgroundColor: Colors.teal.shade600,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                    onPressed: () {},
                    child: const Text(
                      "登録",
                      style: TextStyle(fontSize: 20),
                    ),
                  ))
            ]))));
  }
}
