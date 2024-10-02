import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final LinearGradient backgroundGradient;

  const ThemeState({required this.backgroundGradient});

  static LinearGradient get defaultTheme => const LinearGradient(
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

  static LinearGradient get darkTheme => const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFF000000),
          Color(0xFF000000),
        ],
      );

  static const LinearGradient appTheme = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFCC3CEA),
      Color(0xFFCC3CEA),
    ],
  );

  static const LinearGradient bodyTheme = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFCC3CEA),
      Color(0xFFCC3CEA),
    ],
  );

  static const LinearGradient buttonSelectTheme = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF39B070),
      Color(0xFF39B070),
    ],
  );

  @override
  List<Object> get props => [backgroundGradient];
}
