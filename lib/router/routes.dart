import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';

import '../pages/login/login_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case loginPageRoute:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );

    default:
      return MaterialPageRoute(
        builder: (context) => const LoginPage(),
      );
  }
}
