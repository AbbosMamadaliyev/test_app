import 'package:dio/dio.dart';
import 'package:test_app/domain/models/cat_model.dart';

class ApiClient {
  final String _baseUrl = 'https://cat-fact.herokuapp.com';
  final String _randomImg = 'https://cataas.com/cat';
  final String _param = '/facts/random';

  final dio = Dio();

  Future<CatFactModel> getFact() async {
    final response = await dio.get('$_baseUrl$_param');
    final request = CatFactModel.fromMap(response.data);

    return request;
  }

  String imgUrl() => _randomImg;
}
