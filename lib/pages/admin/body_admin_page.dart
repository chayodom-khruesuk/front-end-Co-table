import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAdminPage extends StatelessWidget {
  const BodyAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoadingUserState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ReadyUserState) {
          final sortedUsers = List.from(state.userList)
            ..sort((a, b) => a.id.compareTo(b.id));

          return ListView.builder(
            itemCount: sortedUsers.length,
            itemBuilder: (context, index) {
              final user = sortedUsers[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('ID: ${user.id}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Name: ${user.name}'),
                      Text('Username: ${user.username}'),
                      Text('Email: ${user.email}'),
                      Text('Role: ${user.roles}'),
                      Text('Faculty: ${user.faculty}'),
                    ],
                  ),
                ),
              );
            },
          );
        }
        return const Center(child: Text('No users found'));
      },
    );
  }
}
