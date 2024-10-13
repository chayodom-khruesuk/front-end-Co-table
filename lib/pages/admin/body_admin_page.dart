import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/core.dart';
import 'package:co_table/models/models.dart';
import 'package:co_table/pages/admin/edit_data_user.dart';
import 'package:co_table/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../widget/blur_dialog.dart';
import '../../widget/filter_button.dart';

class BodyAdminPage extends StatefulWidget {
  const BodyAdminPage({super.key});

  @override
  BodyAdminPageState createState() => BodyAdminPageState();
}

class BodyAdminPageState extends State<BodyAdminPage> {
  String _currentFilter = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state is LoadingUserState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is ReadyUserState) {
          final filteredUsers = _currentFilter == 'All'
              ? state.userList
              : state.userList
                  .where((user) => user.roles == _currentFilter)
                  .toList();

          final sortedUsers = List.from(filteredUsers)
            ..sort((a, b) => a.id.compareTo(b.id));

          return Column(
            children: [
              Row(
                children: [
                  const Expanded(child: SearchWidget()),
                  UserFilterButton(
                    currentFilter: _currentFilter,
                    onFilterChanged: (String newFilter) {
                      setState(() {
                        _currentFilter = newFilter;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.06),
                  child: Column(
                    children: sortedUsers.map((user) {
                      return GestureDetector(
                        onTap: () => _showEditDialog(context, user),
                        child: Container(
                          width: double.infinity,
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
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
                                Text('ID: ${user.id}',
                                    style: GoogleFonts.notoSansThai(
                                        textStyle: const TextStyle(
                                      color: Color(0xFF030260),
                                      fontWeight: FontWeight.bold,
                                    ))),
                                const SizedBox(height: 5),
                                Text('ชื่อเล่น: ${user.name}',
                                    style: GoogleFonts.notoSansThai(
                                        textStyle: const TextStyle(
                                      color: Color(0xFF030260),
                                      fontWeight: FontWeight.w500,
                                    ))),
                                Text('ชื่อผู้ใช้: ${user.username}',
                                    style: GoogleFonts.notoSansThai(
                                        textStyle: const TextStyle(
                                      color: Color(0xFF030260),
                                      fontWeight: FontWeight.w500,
                                    ))),
                                Text('อีเมล: ${user.email}',
                                    style: GoogleFonts.notoSansThai(
                                        textStyle: const TextStyle(
                                      color: Color(0xFF030260),
                                      fontWeight: FontWeight.w500,
                                    ))),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          );
        }
        return const Center(child: Text('No users found'));
      },
    );
  }

  void _showEditDialog(BuildContext context, UserModel user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlurDialog(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'แก้ไขข้อมูลผู้ใช้',
                  style: GoogleFonts.notoSansThai(
                      textStyle: const TextStyle(
                    color: Color(0xFF030260),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  )),
                ),
              ),
              EditDataUser(user: user, userId: user.id),
            ],
          ),
        );
      },
    );
  }
}
