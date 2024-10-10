sealed class UserEvent {}

class LoadUserEvent extends UserEvent {}

class LoadUserListEvent extends UserEvent {
  final int page;
  LoadUserListEvent({this.page = 1});
}

class CreateUserEvent extends UserEvent {
  final String username;
  final String name;
  final String email;
  final String password;

  CreateUserEvent({
    required this.username,
    required this.name,
    required this.email,
    required this.password,
  });
}

class LoginUserEvent extends UserEvent {
  final String username;
  final String password;
  LoginUserEvent({required this.username, required this.password});
}

class UpdateUserEvent extends UserEvent {
  final String email;
  final String name;
  final String? faculty;
  UpdateUserEvent({
    required this.email,
    required this.name,
    this.faculty,
  });
}

class ChangePasswordEvent extends UserEvent {
  final String currentPassword;
  final String newPassword;

  ChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
  });
}

class LogoutUserEvent extends UserEvent {}

class ForgotPasswordEvent extends UserEvent {
  final String email;
  final String newPassword;
  ForgotPasswordEvent({required this.email, required this.newPassword});
}
