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
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).size.height * 0.07,
        left: 16,
        right: 16,
      ),
      child: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is ReadyUserState) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: state.userList.length,
              itemBuilder: (context, index) {
                final user = state.userList[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Username: ${user.username}'),
                        Text('Email: ${user.email}'),
                        Text('Faculty: ${user.faculty}'),
                        Text('Roles: ${user.roles}'),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
