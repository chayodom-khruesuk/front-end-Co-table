import 'package:co_table/bloc/reservation/reservation_bloc.dart';
import 'package:co_table/bloc/reservation/reservation_event.dart';
import 'package:co_table/repositories/reservation/reservation_repo.dart';
import 'package:co_table/repositories/reservation/reservation_repo_db.dart';
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
        RepositoryProvider<ReservationRepo>(
            create: (context) => ReservationRepoDb())
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
          ),
          BlocProvider<ReservationBloc>(
            create: (context) {
              final bloc = ReservationBloc(
                  reservationRepo: context.read<ReservationRepo>());
              bloc.add(LoadReservationEvent());
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
