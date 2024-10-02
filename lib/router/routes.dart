import 'package:co_table/pages/forgot/forgot_page.dart';
import 'package:co_table/widget/navbar.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../pages/signup/signup_page.dart';
import '../pages/splash/splash_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case splashPageRoute:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashPage(),
        transitionDuration: const Duration(seconds: 1),
      );

    case navBarRoute:
    case homePageRoute:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const NavWithAnimated(),
        transitionDuration: const Duration(milliseconds: 300),
      );

    case loginPageRoute:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const LoginPage(),
        transitionDuration: const Duration(seconds: 1),
      );

    case forgotPageRoute:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const ForgotPage(),
        transitionDuration: const Duration(seconds: 1),
      );

    case signupPageRoute:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SignupPage(),
        transitionDuration: const Duration(seconds: 1),
      );
    default:
      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            const SplashPage(),
        transitionDuration: const Duration(seconds: 1),
      );
  }
}
