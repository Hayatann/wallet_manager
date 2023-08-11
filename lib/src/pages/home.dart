import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final consumeTitleProvider = StateProvider<String>((ref) => "");
final consumeGenreProvider = StateProvider<String>((ref) => "");
final consumePriceProvider = StateProvider<String>((ref) => "");
final consumeManageDateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    StateController<String> consumeTitle =
        ref.watch(consumeTitleProvider.notifier);
    StateController<String> consumeGenre =
        ref.watch(consumeGenreProvider.notifier);
    StateController<String> consumePrice =
        ref.watch(consumePriceProvider.notifier);
    StateController<DateTime> consumeManageDate =
        ref.watch(consumeManageDateProvider.notifier);
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
                    consumeTitle.state,
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
                    onChanged: (text) {
                      consumeTitle.state = text;
                      // print(consumeTitle.state);
                    },
                  ),
                ]),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      consumeGenre.state,
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
                      onChanged: (text) {
                        consumeGenre.state = text;
                        // print(consumeGenre.state);
                      },
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Text(
                      consumePrice.state,
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
                      onChanged: (text) {
                        consumePrice.state = text;
                        // print(consumePrice.state);
                      },
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
                  onPressed: () {
                    DatePicker.showDatePicker(
                      context,
                      showTitleActions: true,
                      minTime: DateTime(1950, 1, 1),
                      maxTime: DateTime.now(),
                      onChanged: (date) {
                        print("change $date");
                        consumeManageDate.state = date;
                      },
                      onConfirm: (date) {
                        consumeManageDate.state = date;
                        print(consumeManageDate.state);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.jp,
                    );
                  },
                  child: const Text(
                    "日付を選択",
                    style: TextStyle(fontSize: 20),
                  ),
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
