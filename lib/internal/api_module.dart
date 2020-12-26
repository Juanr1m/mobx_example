import 'package:habr_clean_architecture/data/api/api_util.dart';
import 'package:habr_clean_architecture/data/api/service/sunrise_service.dart';

class ApiModule {
  static ApiUtil _apiUtil;
  static ApiUtil apiUtil() {
    if (_apiUtil == null) {
      _apiUtil = ApiUtil(SunriseServise());
    }
    return _apiUtil;
  }
}
