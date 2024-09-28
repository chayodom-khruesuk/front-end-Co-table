import 'package:co_table/repositories/user/user_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepo userRepo;

  UserBloc({required this.userRepo}) : super(LoadingUserState()) {
    on<LoadUserEvent>(_onLoadUserEvent);
    on<CreateUserEvent>(_onCreateUserEvent);
    on<LoginUserEvent>(_onLoginUserEvent);
    on<LogoutUserEvent>(_onLogoutUserEvent);
    on<ForgotPasswordEvent>(_onForgotPasswordEvent);
  }

  _onLoadUserEvent(LoadUserEvent event, Emitter<UserState> emit) async {
    if (state is LoadingUserState) {
      final user = await userRepo.getUser();
      emit(ReadyUserState(user: user));
    }
  }

  _onCreateUserEvent(CreateUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepo.createUser(
        username: event.username,
        email: event.email,
        roles: event.roles,
        faculty: event.faculty,
        password: event.password,
      );
      emit(LoadingUserState(responseText: response));
    }
  }

  _onLoginUserEvent(LoginUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepo.loginUser(
        username: event.username,
        password: event.password,
      );
      emit(LoadingUserState(responseText: response));
    }
  }

  _onLogoutUserEvent(LogoutUserEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      await userRepo.logoutUser();
      emit(LoadingUserState());
    }
  }

  _onForgotPasswordEvent(
      ForgotPasswordEvent event, Emitter<UserState> emit) async {
    if (state is ReadyUserState) {
      final response = await userRepo.forgotPassword(
        email: event.email,
        newPassword: event.password,
      );
      emit(LoadingUserState(responseText: response));
      add(LoadUserEvent());
    }
  }
}
