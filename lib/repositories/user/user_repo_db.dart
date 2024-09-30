import 'package:co_table/models/user_model.dart';
import 'package:co_table/repositories/user/user_repo.dart';
import 'package:co_table/services/api_service.dart';

class UserRepoDb extends UserRepo {
  late UserModel user;

  final ApiService apiService = ApiService();
  final String baseUrl = '/users';

  @override
  Future<String> createUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final Map<String, dynamic> userData = {
      'username': username,
      'email': email,
      'password': password,
    };

    final response = await apiService.post('$baseUrl/create/', data: userData);
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
    final response = await apiService.post('$baseUrl/forgot-password/',
        data: {'email': email, 'new_password': newPassword});
    if (response.statusCode == 200) {
      return "Password reset successfully";
    } else if (response.statusCode == 404) {
      return response.data['detail'];
    } else {
      throw Exception('Failed to reset password');
    }
  }

  @override
  Future<UserModel> getUser() async {
    final response = await apiService.get('$baseUrl/me');
    if (response.statusCode == 200) {
      user = UserModel.fromJson(response.data);
      return user;
    } else if (response.statusCode == 401) {
      return UserModel.empty();
    } else {
      throw Exception('Failed to get user');
    }
  }

  @override
  Future<void> logoutUser() async {
    await apiService.logout();
  }
}
