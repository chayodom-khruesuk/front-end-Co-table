import 'package:co_table/models/models.dart';
import 'package:co_table/repositories/user/user_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(LoadingUserState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<LoadUserListEvent>(_onLoadUserListEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
    on<LoginUserEvent>(_onLoginUserEvent);
    on<LogoutUserEvent>(_onLogoutUserEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
  }

  _onLoadUserEvent(LoadUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      final user = await userRepo.getUser();
      debugPrint("user: ${user.toString()}");
      emit(ReadyUserState(user: user, userList: emptyUserList));
    }
  }

  _onLoadUserListEvent(LoadUserListEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      final users = await userRepo.getAllUser(page: event.page);
      emit(ReadyUserState(user: UserModel.empty(), userList: users));
    }
  }

  _onCreateUserEvent(CreateUserEvent event, Emitter<UserState> emit) async {
    final response = await userRepo.createUser(
      username: event.username,
      name: event.name,
      email: event.email,
      password: event.password,
    );
    emit(LoadingUserState(responseText: response));
    if (response.contains("สร้างบัญชีสำเร็จ")) {
      add(LoginUserEvent(username: event.username, password: event.password));
    }
  }

  _onLoginUserEvent(LoginUserEvent event, Emitter<UserState> emit) async {
    final response = await userRepo.loginUser(
      username: event.username,
      password: event.password,
    );
    emit(LoadingUserState(responseText: response));
    if (response.contains("เข้าสู่ระบบสำเร็จ")) {
      add(LoadUserEvent());
    } else {
      emit(UserEmptyState(responseText: response));
    }
  }

  _onLogoutUserEvent(LogoutUserEvent event, Emitter<UserState> emit) async {
    await userRepo.logoutUser();
  }

  _onForgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<UserState> emit) async {
    final response = await userRepo.forgotPassword(
      email: event.email,
      newPassword: event.newPassword,
    );
    emit(LoadingUserState(responseText: response));
  }
}
