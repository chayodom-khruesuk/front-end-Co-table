import 'package:co_table/models/user_model.dart';
import 'package:co_table/repositories/user/user_repo.dart';
import 'package:co_table/services/api_service.dart';
import 'package:flutter/material.dart';

class UserRepoDb extends UserRepo {
  late List<UserModel> users = [];
  late UserModel user;
  late UserModelList userList;

  final ApiService apiService = ApiService();
  final String _baseUrl = '/users';

  @override
  Future<String> createUser({
    required String username,
    required String name,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> userData = {
      'username': username,
      'name': name,
      'email': email,
      'password': password
    };

    debugPrint("userData: $userData");
    final response = await apiService.post('$_baseUrl/create', query: userData);
    if (response.statusCode == 200) {
      return "User created successfully";
    } else if (response.statusCode == 409) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to create user');
    }
  }

  @override
  Future<String> loginUser({
    required String username,
    required String password,
  }) async {
    final responseText =
        await apiService.login(username: username, password: password);
    return responseText;
  }

  @override
  Future<String> forgotPassword({
    required String email,
    required String newPassword,
  }) async {
    final response = await apiService.put('$_baseUrl/forgot_password',
        query: {'email': email}, data: {'new_password': newPassword});

    if (response.statusCode == 200) {
      return "Reset password successfully";
    } else if (response.statusCode == 409) {
      return response.data['detail'] ?? "Failed to reset password";
    } else {
      throw Exception('Failed to reset password');
    }
  }

  @override
  Future<UserModel> getUser() async {
    final response = await apiService.get('$_baseUrl/get_me');
    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else if (response.statusCode == 401) {
      return UserModel.empty();
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<List<UserModel>> getAllUser({int page = 1}) async {
    final response = await apiService.get(_baseUrl, query: {'page': page});
    if (response.statusCode == 200) {
      final userList = UserModelList.fromJson(response.data);
      users = userList.users;
      return users;
    } else {
      throw Exception('Failed to get all user');
    }
  }

  @override
  Future<void> logoutUser() async {
    await apiService.logout();
  }
}
