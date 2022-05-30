import 'package:hive/hive.dart';
import 'package:test_app/domain/models/cat_model.dart';

class LocalDataProvider {
  final String _boxName = 'fact_box';

  Box<CatFactModel> box() => Hive.box<CatFactModel>(_boxName);

  Future<Box<CatFactModel>> openBox() async =>
      await Hive.openBox<CatFactModel>(_boxName);
}
