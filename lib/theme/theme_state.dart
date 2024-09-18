import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final LinearGradient backgroundGradient;

  const ThemeState({required this.backgroundGradient});

  static LinearGradient get defualtTheme => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFCC3CEA),
          Color(0xFFCC3CEA),
        ],
      );

  static LinearGradient get lightTheme => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFFFFFF),
          Color(0xFFFFFFFF),
        ],
      );

  @override
  List<Object> get props => [backgroundGradient];
}
