import 'package:co_table/pages/forgot/forgot_page.dart';
import 'package:co_table/pages/widget/navbar.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';
import '../pages/signup/singup_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case navBarRoute:
    case homePageRoute:
      return MaterialPageRoute(
        builder: (context) => const NavWithAnimated(),
      );

    case loginPageRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );

    case forgotPageRoute:
      return MaterialPageRoute(
        builder: (context) => const ForgotPage(),
      );

    case signupPageRoute:
      return MaterialPageRoute(
        builder: (context) => const SignupPage(),
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const NavWithAnimated(),
      );
  }
}
