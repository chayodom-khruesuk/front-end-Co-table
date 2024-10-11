import '../../models/models.dart';

sealed class UserState {
  final UserModel user;
  final List<UserModel> userList;
  final String responseText;
  UserState({
    required this.user,
    required this.userList,
    this.responseText = '',
  });
}

class LoadingUserState extends UserState {
  LoadingUserState({super.responseText})
      : super(user: UserModel.empty(), userList: []);
}

class UserEmptyState extends UserState {
  UserEmptyState({super.responseText})
      : super(user: UserModel.empty(), userList: []);
}

class ReadyUserState extends UserState {
  final int currentPage;
  final bool isDataLoaded;

  ReadyUserState({
    required super.user,
    required super.userList,
    this.currentPage = 0,
    this.isDataLoaded = false,
  });
}
