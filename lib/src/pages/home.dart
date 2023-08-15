import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../db/consumes.dart';
import '../db/db_helper.dart';

final consumeTitleProvider = StateProvider<String>((ref) => "");
final consumeGenreProvider = StateProvider<String>((ref) => "");
final consumePriceProvider = StateProvider<String>((ref) => "");
final consumeManageDateProvider =
    StateProvider<DateTime>((ref) => DateTime.now());
final globalKeyProvider = Provider(
  (ref) => GlobalKey<FormState>(),
);

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final consumeTitle = ref.watch(consumeTitleProvider);
    final consumeTitleController = ref.read(consumeTitleProvider.notifier);
    final consumeGenre = ref.watch(consumeGenreProvider);
    final consumeGenreController = ref.read(consumeGenreProvider.notifier);
    final consumePrice = ref.watch(consumePriceProvider);
    final consumePriceController = ref.read(consumePriceProvider.notifier);
    final consumeManageDateController =
        ref.read(consumeManageDateProvider.notifier);
    final consumeManageDate = ref.watch(consumeManageDateProvider);
    final globalKey = ref.watch(globalKeyProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          centerTitle: true,
          title: const Text('家計簿', style: TextStyle(color: Colors.white)),
        ),
        body: Form(
            key: globalKey,
            child: Padding(
                padding: const EdgeInsets.all(60.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      TextFormField(
                        enabled: true,
                        decoration: const InputDecoration(
                          floatingLabelAlignment: FloatingLabelAlignment.center,
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          labelStyle: TextStyle(fontSize: 30),
                          labelText: "支出のタイトル",
                          hintText: "例: コンビニ弁当",
                          border: OutlineInputBorder(),
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "支出のタイトルを入力してください";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          consumeTitleController.state = text;
                          // print(consumeTitle.state);
                        },
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: const InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            labelStyle: TextStyle(fontSize: 30),
                            labelText: "支出のジャンル",
                            hintText: "例: 食費",
                            border: OutlineInputBorder()),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "支出のジャンルを入力してください";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          consumeGenreController.state = text;
                          // print(consumeGenre.state);
                        },
                      ),
                      TextFormField(
                        enabled: true,
                        decoration: const InputDecoration(
                            floatingLabelAlignment:
                                FloatingLabelAlignment.center,
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
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "支出額を入力してください";
                          } else if (int.tryParse(value) == null) {
                            return "数字を入力してください";
                          } else if (value.length > 9) {
                            return "9桁以内で入力してください";
                          }
                          return null;
                        },
                        onChanged: (text) {
                          consumePriceController.state = text;
                          // print(consumePrice.state);
                        },
                      ),
                      ElevatedButton(
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
                              // consumeManageDateController.state = date;
                            },
                            onConfirm: (date) {
                              consumeManageDateController.state = date;
                              print(consumeManageDate);
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
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(200, 50),
                            backgroundColor: Colors.teal.shade600,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                        onPressed: () async {
                          // ヴァリデーションが上手くいったら
                          if (globalKey.currentState!.validate()) {
                            final consumes = Consumes(
                              title: consumeTitle,
                              price: int.parse(consumePrice),
                              genre: consumeGenre,
                              date: consumeManageDate,
                              createdAt: DateTime.now(),
                            );
                            await DbHelper.instance.insert(consumes);
                          }
                        },
                        child: const Text(
                          "登録",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ]))));
  }
}
