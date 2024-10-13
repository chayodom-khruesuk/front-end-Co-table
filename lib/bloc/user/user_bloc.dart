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
    on<UpdateUserEvent>(_onUpdateUserEvent);
    on<ChangePasswordEvent>(_onChangePasswordEvent);

    add(LoadUserEvent());
    add(LoadUserListEvent());
  }

  _onLoadUserEvent(LoadUserEvent event, Emitter<UserState> emit) async {
    emit(LoadingUserState());
    try {
      final user = await userRepo.getUser();
      final userList = await userRepo.getAllUser(page: 1);
      debugPrint("user: ${user.toString()}");
      emit(ReadyUserState(
          user: user, userList: userList, currentPage: 1, isDataLoaded: true));
    } catch (e) {
      emit(UserEmptyState(responseText: e.toString()));
    }
  }

  _onLoadUserListEvent(LoadUserListEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final currentState = state as ReadyUserState;
      if (!currentState.isDataLoaded) {
        emit(LoadingUserState());
        try {
          final users = await userRepo.getAllUser(page: event.page);
          emit(ReadyUserState(
            user: currentState.user,
            userList: users,
            currentPage: event.page,
            isDataLoaded: true,
          ));
        } catch (e) {
          emit(ReadyUserState(
            user: currentState.user,
            userList: [],
            currentPage: 0,
            isDataLoaded: true,
          ));
        }
      }
    } else {
      emit(LoadingUserState());
      try {
        final users = await userRepo.getAllUser(page: event.page);
        emit(ReadyUserState(
            user: UserModel.empty(), userList: users, currentPage: event.page));
      } catch (e) {
        emit(ReadyUserState(
            user: UserModel.empty(), userList: [], currentPage: 0));
      }
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
      await _onLoginUserEvent(
          LoginUserEvent(username: event.username, password: event.password),
          emit);
      add(LoadUserEvent());
    }
  }

  _onLoginUserEvent(LoginUserEvent event, Emitter<UserState> emit) async {
    final response = await userRepo.loginUser(
      username: event.username,
      password: event.password,
    );
    emit(LoadingUserState(responseText: response));
    if (response.contains("เข้าสู่ระบบสำเร็จ")) {
      final user = await userRepo.getUser();
      emit(ReadyUserState(user: user, userList: []));
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

  _onUpdateUserEvent(UpdateUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final currentUser = (state as ReadyUserState).user;
      final response = await userRepo.updateUser(
        userId: currentUser.id,
        email: event.email,
        name: event.name,
        faculty: event.faculty ?? 'ไม่มีคณะ',
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }

  _onChangePasswordEvent(
      ChangePasswordEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final currentUser = (state as ReadyUserState).user;
      final response = await userRepo.changePassword(
        userId: currentUser.id,
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }
}
