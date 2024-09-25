import 'package:co_table/pages/signup/form_signup_page.dart';
import 'package:co_table/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';
import '../../theme/widget/clip_path.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return Scaffold(
        backgroundColor: Colors.grey[300],
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                ClipPath(
                  clipper: CustomClipPath(),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: themeState.backgroundGradient,
                    ),
                    height: 275,
                  ),
                ),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: FormSignupPage(),
                  ),
                ),
                Positioned(
                  top: 75,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Image.asset(ImageConstant.headerImg),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
