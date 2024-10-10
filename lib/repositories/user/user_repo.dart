import 'package:co_table/models/models.dart';

abstract class UserRepo {
  Future<String> createUser({
    required String username,
    required String name,
    required String email,
    required String password,
  });

  Future<String> loginUser({
    required String username,
    required String password,
  });

  Future<UserModel> getUser();

  Future<List<UserModel>> getAllUser({int page = 1});

  Future<String> forgotPassword({
    required String email,
    required String newPassword,
  });

  Future<String> changePassword({
    required int userId,
    required String currentPassword,
    required String newPassword,
  });

  Future<String> updateUser({
    required int userId,
    required String email,
    required String name,
    required String faculty,
  });

  Future<void> logoutUser();
}
