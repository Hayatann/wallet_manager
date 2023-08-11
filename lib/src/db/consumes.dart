import './db_helper.dart';
import 'package:intl/intl.dart';

// consumesテーブルの定義
class Consumes {
  int? id;
  String title;
  int price; // 読みこむときはint型で読み込む
  String genre;
  DateTime date;
  DateTime createdAt;

  Consumes({
    this.id,
    required this.title,
    required this.price,
    required this.genre,
    required this.date,
    required this.createdAt,
  });

  Consumes copy({
    int? id,
    String? title,
    int? price,
    String? genre,
    DateTime? date,
    DateTime? createdAt,
  }) =>
      Consumes(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        genre: genre ?? this.genre,
        date: date ?? this.date,
        createdAt: createdAt ?? this.createdAt,
      );

  static Consumes fromJson(Map<String, Object?> json) => Consumes(
        id: json[columnId] as int?,
        title: json[columnTitle] as String,
        price: json[columnPrice] as int,
        genre: json[columnGenre] as String,
        date: DateTime.parse(json[columnDate] as String),
        createdAt: DateTime.parse(json[columnCreatedAt] as String),
      );

  Map<String, Object> toJson() => {
        columnTitle: title, // なんか知らんけどidは入れんでいいらしい
        columnPrice: price,
        columnGenre: genre,
        columnDate: DateFormat('yyyy-MM-dd').format(date),
        columnCreatedAt: DateFormat('yyyy-MM-dd HH:mm:ss').format(createdAt),
      };
}
