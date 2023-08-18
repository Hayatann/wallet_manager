import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallet_manager/src/db/consumes.dart';
import 'package:wallet_manager/src/pages/home.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:nil/nil.dart';
import '../db/db_helper.dart';

final consumesListProvider =
    FutureProvider.autoDispose<List<Consumes>>((ref) async {
  final consumesList = await DbHelper.instance.selectAllConsumes();
  return consumesList;
});

class RecordPage extends ConsumerStatefulWidget {
  const RecordPage({Key? key}) : super(key: key);

  @override
  RecordPageState createState() => RecordPageState();
}

class RecordPageState extends ConsumerState<RecordPage> {
  final dateFormatter = DateFormat('MM/dd');
  @override
  Widget build(BuildContext context) {
    final consumesList = ref.watch(consumesListProvider);

    int consumePriceSum = consumesList.when(data: (consumeList) {
      int sum = 0;
      for (int i = 0; i < consumeList.length; i++) {
        sum += consumeList[i].price;
      }
      return sum;
    }, error: (error, stacktrace) {
      return 0;
    }, loading: () {
      return 0;
    });

    Map<String, double>? dataMap = consumesList.when(data: (consumeList) {
      Map<String, double> dataMap = {};
      for (int i = 0; i < consumeList.length; i++) {
        dataMap[consumeList[i].title] = consumeList[i].price.toDouble();
      }
      debugPrint(dataMap.toString());
      return dataMap;
    }, error: (error, stacktrace) {
      return null;
    }, loading: () {
      return null;
    });
    bool dataMapIsEmpty = dataMap == null ? true : false;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          centerTitle: true,
          title: const Text('家計簿', style: TextStyle(color: Colors.white)),
        ),
        body: consumesList.when(data: (consumeList) {
          return SingleChildScrollView(
              child: Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: <Widget>[
                      Text("合計" + " " + consumePriceSum.toString() + '円',
                          style: const TextStyle(fontSize: 30)),
                      dataMapIsEmpty ? nil : PieChart(dataMap: dataMap),
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: consumeList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final consume = consumeList[index];
                            return Card(
                                margin: const EdgeInsets.all(20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(
                                        consume.title,
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        consume.genre,
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        consume.price.toString() + '円',
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(
                                        dateFormatter.format(consume.date),
                                        style: const TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                          })
                    ],
                  )));
        }, error: (error, stackTrace) {
          return Text(error.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
