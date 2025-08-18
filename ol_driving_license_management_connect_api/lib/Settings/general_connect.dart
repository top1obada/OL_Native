import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  //http://oldlm.runasp.net/api/
  // Dio ثابت وفوري الإنشاء
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'http://oldlm.runasp.net/api/',

      headers: {'Content-Type': 'application/json'},
    ),
  );

  // تضيف التوكن وتحذف LoginData
  static void setAuthToken(String token) {
    dio.options.headers['Authorization'] = 'Bearer $token';
    dio.options.headers.remove('LoginData');
  }

  // تضيف LoginData وتحذف التوكن
  static void setLoginData(String loginData) {
    dio.options.headers['LoginData'] = loginData;
    dio.options.headers.remove('Authorization');
  }

  static void clearHeaders() {
    dio.options.headers.remove('Authorization');
    dio.options.headers.remove('LoginData');
  }
}
