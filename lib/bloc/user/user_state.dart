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

const List<UserModel> emptyUserList = [];

class LoadingUserState extends UserState {
  LoadingUserState({super.responseText})
      : super(user: UserModel.empty(), userList: emptyUserList);
}

class UserEmptyState extends UserState {
  UserEmptyState({super.responseText})
      : super(user: UserModel.empty(), userList: emptyUserList);
}

class ReadyUserState extends UserState {
  ReadyUserState({required super.user, required super.userList});
}
