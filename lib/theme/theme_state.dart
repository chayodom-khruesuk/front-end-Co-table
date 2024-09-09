import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ThemeState extends Equatable {
  final LinearGradient backgroundGradient;

  const ThemeState({required this.backgroundGradient});

  @override
  List<Object> get props => [backgroundGradient];
}
