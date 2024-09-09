import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../theme/widget/clip_path.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Scaffold(
        body: ClipPath(
          clipper: CustomClipPath(),
          child: Container(
            decoration: BoxDecoration(
              gradient: themeState.backgroundGradient,
            ),
          ),
        ),
      );
    });
  }
}
