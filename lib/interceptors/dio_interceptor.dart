import 'package:dio/dio.dart';
import 'package:co_table/services/services.dart';

class DioInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await Token.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.headers['Content-Type'] = 'application/json';
    options.baseUrl = 'https://co-table-application.onrender.com';

    super.onRequest(options, handler);
  }
}
