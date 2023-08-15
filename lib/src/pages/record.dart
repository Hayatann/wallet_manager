import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:wallet_manager/src/db/consumes.dart';
import 'package:wallet_manager/src/pages/home.dart';
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
  @override
  Widget build(BuildContext context) {
    final consumesList = ref.watch(consumesListProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal.shade900,
          centerTitle: true,
          title: const Text('家計簿', style: TextStyle(color: Colors.white)),
        ),
        body: consumesList.when(data: (consumeList) {
          return ListView.builder(
              itemCount: consumeList.length,
              itemBuilder: (BuildContext context, int index) {
                final consume = consumeList[index];
                return Card(
                  child: ListTile(
                    title: Text(consume.title),
                    subtitle: Text(consume.genre),
                    trailing: Text(consume.price.toString()),
                  ),
                );
              });
        }, error: (error, stackTrace) {
          return Text(error.toString());
        }, loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }
}
