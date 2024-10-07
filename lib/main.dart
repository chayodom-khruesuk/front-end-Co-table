import 'package:co_table/bloc/widget/widget_bloc.dart';
import 'package:co_table/repositories/user/user_repo_db.dart';
import 'package:co_table/services/services.dart';
import 'package:co_table/theme/theme_bloc.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';
import 'package:co_table/router/routes.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider<UserBloc>(create: (context) {
          final bloc = UserBloc(userRepo: UserRepoDb());
          Token.getToken().then((token) {
            if (token != null && token.isNotEmpty) {
              bloc.add(LoadUserEvent());
            }
          });
          return bloc;
        }),
        BlocProvider<WidgetBloc>(create: (context) => WidgetBloc(allRooms: [])),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: router.generateRoute,
        initialRoute: splashPageRoute,
      ),
    );
  }
}
