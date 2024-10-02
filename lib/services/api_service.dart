import 'package:co_table/interceptors/dio_interceptor.dart';
import 'package:co_table/services/token.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class ApiService {
  late final Dio _dio;

  ApiService() {
    _dio = Dio();
    _dio.interceptors.add(DioInterceptor());
  }

  Future<Response> get(String path, {Map<String, dynamic>? query}) async {
    try {
      final response = await _dio.get(path, queryParameters: query);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Response> post(String path,
      {Object? data, Options? options, Map<String, dynamic>? query}) async {
    try {
      debugPrint("Request data: $data");
      final response = await _dio.post(path,
          data: data, options: options, queryParameters: query);
      debugPrint("Response data: ${response.data}");
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        return Response(
          requestOptions: e.requestOptions,
          statusCode: 409,
          data: e.response?.data,
        );
      }
      debugPrint('DioException: ${e.toString()}');
      debugPrint('Response: ${e.response}');
      rethrow;
    }
  }

  Future<Response> put(String path,
      {Object? data, Map<String, dynamic>? query}) async {
    try {
      debugPrint("Request data: $data");
      final response = await _dio.put(path, data: data, queryParameters: query);
      debugPrint("Response data: ${response.data}");
      return response;
    } on DioException catch (e) {
      debugPrint('DioException: ${e.toString()}');
      debugPrint('Response: ${e.response}');
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<String> login(
      {required String username, required String password}) async {
    try {
      final response = await _dio.post(
        '/token',
        data: FormData.fromMap({'username': username, 'password': password}),
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
        ),
      );

      if (response.statusCode == 200) {
        final token = response.data['access_token'];
        await Token.setToken(token);
        return "เข้าสู่ระบบสำเร็จ";
      } else if (response.statusCode == 401) {
        // detail: Incorrect username or password.
        return "ชื่อบัญชีผู้ใช้หรือรหัสผ่านไม่ถูกต้อง";
      } else {
        return "Something went wrong";
      }
    } catch (e) {
      if (e is DioException && e.response?.statusCode == 401) {
        debugPrint("Incorrect username or password");
        return "ชื่อบัญชีผู้ใช้หรือรหัสผ่านไม่ถูกต้อง";
      }
      debugPrint(e.toString());
      return e.toString();
    }
  }

  Future<void> logout() async {
    await Token.clearToken();
  }

  patch(String s, {required Map<String, String> data}) {}
}
