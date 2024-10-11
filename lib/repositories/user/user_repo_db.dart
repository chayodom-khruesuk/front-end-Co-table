import 'package:co_table/models/user_model.dart';
import 'package:co_table/repositories/user/user_repo.dart';
import 'package:flutter/material.dart';

import '../../services/services.dart';

class UserRepoDb extends UserRepo {
  late UserModel user = UserModel.empty();
  late List<UserModel> users = [];
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
    final response =
        await apiService.login(username: username, password: password);
    if (response['status'] == 'success') {
      return response['message'];
    } else if (response['status'] == 'error') {
      return response['message'];
    } else {
      throw Exception('Unexpected response format');
    }
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
    final response =
        await apiService.get('$_baseUrl/get_allUser', query: {'page': page});
    if (response.statusCode == 200) {
      final userList = UserModelList.fromJson(response.data);
      return userList.users;
    } else {
      throw Exception('Failed to get all users');
    }
  }

  @override
  Future<String> updateUser({
    required String email,
    required String name,
    String? faculty,
    required int userId,
  }) async {
    final userId = await Token.getUserId();
    final data = {'email': email, 'name': name};
    if (faculty != null) {
      data['faculty'] = faculty;
    }
    final response = await apiService
        .put('$_baseUrl/update_user', data: data, query: {'user_id': userId});
    debugPrint("response: ${response.data}");
    if (response.statusCode == 200) {
      return "User updated successfully";
    } else if (response.statusCode == 422) {
      return "Invalid data provided: ${response.data['detail']}";
    } else if (response.statusCode == 403) {
      return "Not enough permissions";
    } else if (response.statusCode == 404) {
      return "User not found";
    } else {
      throw Exception('Failed to update user');
    }
  }

  @override
  Future<String> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  }) async {
    final userId = await Token.getUserId();
    final response = await apiService.put(
      '$_baseUrl/change_password',
      data: {'current_password': currentPassword, 'new_password': newPassword},
      query: {'user_id': userId},
    );

    if (response.statusCode == 200) {
      return "Password changed successfully";
    } else if (response.statusCode == 400) {
      return response.data['detail'] ?? "Failed to change password";
    } else {
      throw Exception('Failed to change password');
    }
  }

  @override
  Future<void> logoutUser() async {
    await apiService.logout();
  }
}
