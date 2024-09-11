import 'package:flutter/material.dart';
import 'package:co_table/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(const ThemeState(backgroundGradient: _defaultGradient)) {
    on<LoadTheme>((event, emit) =>
        emit(const ThemeState(backgroundGradient: _defaultGradient)));
  }

  static const LinearGradient _defaultGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFD83DF2),
      Color(0xFF32238C),
    ],
  );
}
