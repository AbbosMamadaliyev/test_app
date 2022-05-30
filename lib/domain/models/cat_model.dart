import 'package:hive/hive.dart';

part 'cat_model.g.dart';

@HiveType(typeId: 1)
class CatFactModel {
  @HiveField(0)
  final String text;
  @HiveField(1)
  final String createdAt;

//<editor-fold desc="Data Methods">

  const CatFactModel({
    required this.text,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'createdAt': createdAt,
    };
  }

  factory CatFactModel.fromMap(Map<String, dynamic> map) {
    return CatFactModel(
      text: map['text'] as String,
      createdAt: map['createdAt'] as String,
    );
  }

//</editor-fold>
}
