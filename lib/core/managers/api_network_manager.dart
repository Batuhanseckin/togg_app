import 'package:dio/dio.dart';
import 'package:togg_app/core/constants/api_constants.dart';
import 'package:togg_app/core/managers/locale_manager.dart';

class ApiNetworkManager {
  static ApiNetworkManager _instance;
  static ApiNetworkManager get instance => _instance ??= ApiNetworkManager._();

  ApiNetworkManager._() {
    BaseOptions baseOptions = BaseOptions(
      baseUrl: ApiConstants.baseUrl,
    );
    dio = Dio(baseOptions);

    // dio.interceptors.add(RetryOnConnectionChangeInterceptor());
    // dio.interceptors.add(LoggerInterceptor());
    // dio.interceptors.add(LogOutInterceptor());

    String token = LocaleManager.instance.getStringValue(PreferencesKeys.token);
    if (token != null && token.isNotEmpty) {
      setToken(token);
    }
  }

  Dio dio;

  void setBaseUrl(String baseUrl) {
    dio.options.baseUrl = baseUrl;
    ApiConstants.baseUrl = baseUrl;
  }

  void setToken(String token) {
    dio.options.headers = {
      "Authorization": "Bearer " + token,
    };
  }

  void clearToken() {
    dio.options.headers = null;
  }
}
