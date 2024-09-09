import 'package:co_table/theme/theme_bloc.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';
import 'package:co_table/router/routes.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => ThemeBloc(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      initialRoute: loginPageRoute,
    );
  }
}
