import 'package:co_table/repositories/room/room_repo.dart';
import 'package:co_table/repositories/room/room_repo_db.dart';
import 'package:co_table/repositories/table/table_repo.dart';
import 'package:co_table/repositories/table/table_repo_db.dart';
import 'package:co_table/repositories/user/user_repo_db.dart';
import 'package:co_table/services/services.dart';
import 'package:co_table/theme/theme_bloc.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:flutter/material.dart';
import 'package:co_table/router/routes.dart' as router;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bloc.dart';
import 'repositories/user/user_repo.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<UserRepo>(create: (context) => UserRepoDb()),
        RepositoryProvider<RoomRepo>(create: (context) => RoomRepoDb()),
        RepositoryProvider<TableRepo>(create: (context) => TableRepoDb()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ThemeBloc()),
          BlocProvider<UserBloc>(create: (context) {
            final bloc = UserBloc(userRepo: context.read<UserRepo>());
            Token.getToken().then((token) {
              if (token != null && token.isNotEmpty) {
                bloc.add(LoadUserEvent());
              }
            });
            bloc.add(LoadUserListEvent());
            return bloc;
          }),
          BlocProvider<WidgetBloc>(
              create: (context) => WidgetBloc(allRooms: [])),
          BlocProvider<RoomBloc>(
            create: (context) {
              final bloc = RoomBloc(roomRepo: context.read<RoomRepo>());
              bloc.add(LoadRoomListEvent());
              return bloc;
            },
          ),
          BlocProvider<TableBloc>(
            create: (context) {
              final bloc = TableBloc(tableRepo: context.read<TableRepo>());
              bloc.add(LoadTableListEvent());
              return bloc;
            },
          )
        ],
        child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: router.generateRoute,
          initialRoute: splashPageRoute,
        ),
      ),
    );
  }
}
