import 'package:flutter/widgets.dart';
import 'package:habr_clean_architecture/data/api/request/get_day_body.dart';
import 'package:habr_clean_architecture/data/api/service/sunrise_service.dart';
import 'package:habr_clean_architecture/data/mapper/day_mapper.dart';
import 'package:habr_clean_architecture/domain/model/day.dart';

class ApiUtil {
  final SunriseServise _sunriseService;

  ApiUtil(this._sunriseService);

  Future<Day> getDay({
    @required double latitude,
    @required double longitude,
  }) async {
    final body = GetDayBody(latitude: latitude, longitude: longitude);
    final result = await _sunriseService.getDay(body: body);
    return DayMapper.fromApi(result);
  }
}
