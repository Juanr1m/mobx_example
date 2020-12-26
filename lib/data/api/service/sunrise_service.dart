import 'package:dio/dio.dart';

import 'package:habr_clean_architecture/data/api/api_day.dart';
import 'package:habr_clean_architecture/data/api/request/get_day_body.dart';

class SunriseServise {
  static const _BASE_URL = 'https://api.sunrise-sunset.org';

  final Dio _dio = Dio(
    BaseOptions(baseUrl: _BASE_URL),
  );

  Future<ApiDay> getDay({GetDayBody body}) async {
    final response = await _dio.get(
      '/json',
      queryParameters: body.toApi(),
    );
    return ApiDay.fromApi(response.data);
  }
}
