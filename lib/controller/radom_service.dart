import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../model/random_user_model.dart';

class RandomService {
  late Dio dio;

  RandomService() {
    dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
  }

  Future<RandomUserModel> random(int page) async {
    final response =
        await dio.get('https://api.randomuser.me/?results=15&page=$page');
    if (response.statusCode == 200) {
      return RandomUserModel.fromJson(response.data);
    } else {
      throw Exception('Không tải được dữ liệu');
    }
  }
}
