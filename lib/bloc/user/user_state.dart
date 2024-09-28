import '../../models/models.dart';

sealed class UserState {
  final UserModel user;
  final String responseText;
  UserState({required this.user, this.responseText = ''});
}

class LoadingUserState extends UserState {
  LoadingUserState({super.responseText}) : super(user: UserModel.empty());
}

class ReadyUserState extends UserState {
  ReadyUserState({required super.user});
}
