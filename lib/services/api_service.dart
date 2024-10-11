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
      final response = await _dio.put(path, data: data, queryParameters: query);
      debugPrint("Response data: $response");
      return response;
    } on DioException catch (e) {
      if (e.response?.statusCode == 404 ||
          e.response?.statusCode == 409 ||
          e.response?.statusCode == 422) {
        debugPrint('Handled error: ${e.response?.statusCode}');
        return Response(
          requestOptions: e.requestOptions,
          statusCode: e.response?.statusCode,
          data: e.response?.data,
        );
      }
      debugPrint('DioException: ${e.toString()}');
      debugPrint('Response: ${e.response}');
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParameters,
      required Map<String, int> query}) async {
    try {
      final response =
          await _dio.delete(path, queryParameters: queryParameters);
      return response;
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> login(
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
        final userId = response.data['user_id'];
        await Token.setToken(token);
        await Token.setUserId(userId);
        return {
          "status": "success",
          "message": "เข้าสู่ระบบสำเร็จ",
          "token": token,
          "user_id": userId
        };
      } else {
        return {
          "status": "error",
          "message": "ชื่อบัญชีผู้ใช้หรือรหัสผ่านไม่ถูกต้อง"
        };
      }
    } catch (e) {
      return {"status": "error", "message": "เกิดข้อผิดพลาดในการเชื่อมต่อ"};
    }
  }

  Future<void> logout() async {
    await Token.clearToken();
  }
}
