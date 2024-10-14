import 'package:co_table/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../bloc/bloc.dart';
import '../../utils/text_constant.dart';

class EditDataUser extends StatefulWidget {
  final UserModel user;
  final int userId;

  const EditDataUser({super.key, required this.user, required this.userId});

  @override
  EditDataUserState createState() => EditDataUserState();
}

class EditDataUserState extends State<EditDataUser> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _facultyController;
  late String _selectedRole;
  late int _userId;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.name);
    _emailController = TextEditingController(text: widget.user.email);
    _facultyController =
        TextEditingController(text: widget.user.faculty ?? 'ไม่ระบุคณะ');
    _selectedRole = widget.user.roles;
    _userId = widget.userId;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _facultyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(color: Colors.transparent),
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 15),
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  controller: _nameController,
                  style: GoogleFonts.notoSansThai(
                      textStyle: const TextStyle(
                    color: Colors.black,
                  )),
                  decoration: InputDecoration(
                      labelText: 'ชื่อผู้ใช้',
                      labelStyle: GoogleFonts.notoSansThai(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ))),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _emailController,
                  style: GoogleFonts.notoSansThai(
                      textStyle: const TextStyle(
                    color: Colors.black,
                  )),
                  decoration: InputDecoration(
                      labelText: 'อีเมล',
                      labelStyle: GoogleFonts.notoSansThai(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ))),
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(color: Colors.black),
                  ),
                  decoration: InputDecoration(
                    labelText: 'บทบาท',
                    labelStyle: GoogleFonts.notoSansThai(
                      textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  items: ['visitor', 'admin'].map((String role) {
                    return DropdownMenuItem<String>(
                        value: role,
                        child:
                            Text(role, style: const TextStyle(fontSize: 15)));
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue!;
                    });
                  },
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _facultyController,
                  style: GoogleFonts.notoSansThai(
                      textStyle: const TextStyle(
                    color: Colors.black,
                  )),
                  decoration: InputDecoration(
                      labelText: 'คณะ',
                      labelStyle: GoogleFonts.notoSansThai(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                        color: Colors.black,
                      ))),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    OverflowBar(
                      spacing: 10,
                      children: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(TextConstant.cancel,
                                style: GoogleFonts.notoSansThai(
                                    textStyle: const TextStyle(
                                  color: Color(0xFF030260),
                                  fontWeight: FontWeight.bold,
                                )))),
                        TextButton(
                            onPressed: _updateUser,
                            child: Text(TextConstant.confirm,
                                style: GoogleFonts.notoSansThai(
                                    textStyle: const TextStyle(
                                  color: Color(0xFF030260),
                                  fontWeight: FontWeight.bold,
                                )))),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _updateUser() {
    context.read<UserBloc>().add(UpdateUserEvent(
          userId: _userId,
          email: _emailController.text,
          name: _nameController.text,
          faculty: _facultyController.text.isEmpty
              ? 'ไม่ระบุคณะ'
              : _facultyController.text,
          roles: _selectedRole,
        ));

    Navigator.of(context).pop();
  }
}
