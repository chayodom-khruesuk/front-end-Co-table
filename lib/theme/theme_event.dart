import 'package:equatable/equatable.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class LoadTheme extends ThemeEvent {}

class ChangeToDarkTheme extends ThemeEvent {}

class ChangeToLightTheme extends ThemeEvent {}

class AppTheme extends ThemeEvent {}

class SelectTheme extends ThemeEvent {}
