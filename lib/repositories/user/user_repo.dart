import 'package:co_table/models/models.dart';

abstract class UserRepo {
  Future<String> createUser(
      {required String username,
      required String name,
      required String email,
      required String password});

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

  Future<void> logoutUser();
}
