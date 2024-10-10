import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAdminPage extends StatefulWidget {
  const BodyAdminPage({super.key});
  @override
  BodyAdminPageState createState() => BodyAdminPageState();
}

class BodyAdminPageState extends State<BodyAdminPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.07),
      child: BlocBuilder<UserBloc, UserState>(builder: (context, state) {
        // context.read<UserBloc>().add(LoadUserListEvent());
        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.userList.length,
          itemBuilder: (context, index) {
            final user =
                context.select((UserBloc bloc) => bloc.state.userList[index]);
            debugPrint('user');
            return ListTile(
              title: Text(user.name),
              subtitle: Text(user.username),
            );
          },
        );
      }),
    );
  }
}
