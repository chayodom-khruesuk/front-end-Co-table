import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

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

          return SingleChildScrollView(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height * 0.07),
            child: Column(
              children: sortedUsers.map((user) {
                return Container(
                  height: 170,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  decoration: BoxDecoration(
                    gradient: ThemeState.lightTheme,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 0.5,
                        blurRadius: 2,
                        offset: const Offset(0, 0.5),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'ID: ${user.id}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Name: ${user.name}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          'Username: ${user.username}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          'Email: ${user.email}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          'Role: ${user.roles}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Text(
                          'Faculty: ${user.faculty}',
                          style: GoogleFonts.notoSansThai(
                            textStyle: const TextStyle(
                              color: Color(0xFF030260),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
        return const Center(child: Text('No users found'));
      },
    );
  }
}
