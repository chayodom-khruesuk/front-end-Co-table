import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core.dart';
import '../../utils/helper/helper_func.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  BodyProfileState createState() => BodyProfileState();
}

class BodyProfileState extends State<BodyProfile> {
  bool isEditing = false;
  String? _tempEmail;
  String? _tempName;
  String? _tempCurrentPassword;
  String? _tempNewPassword;
  String? editedField;
  String? _currentPassword;
  String? _newPassword;

  final Color grayColor = const Color.fromARGB(255, 184, 181, 181);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themestate) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userstate) {
            if (userstate is LoadingUserState || userstate is UserEmptyState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (userstate is ReadyUserState) {
              final user = userstate.user;
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFE7E5E5),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF860F9E).withOpacity(0.3),
                          offset: const Offset(0, 5),
                          blurRadius: 10,
                          spreadRadius: 10,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(25),
                    margin: const EdgeInsets.all(16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEmailField(themestate, user.email ?? ''),
                        const SizedBox(height: SizeConstant.defaultPadding),
                        _buildUsernameField(themestate, user.username ?? ''),
                        const SizedBox(height: SizeConstant.defaultPadding),
                        _buildNameField(themestate, user.name ?? ''),
                        const SizedBox(height: SizeConstant.defaultPadding),
                        _buildFacultyField(themestate, user.faculty ?? ''),
                        const SizedBox(height: SizeConstant.defaultPadding),
                        _buildPasswordField(themestate, '***********'),
                        const SizedBox(height: SizeConstant.defaultPadding),
                        _buildEditButton(),
                      ],
                    ),
                  ),
                  _buildLogoutButton(),
                ],
              );
            }
            return const Center(child: Text('No users found'));
          },
        );
      },
    );
  }

  Widget _buildEmailField(ThemeState state, String email) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.user_circle, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: isEditing && editedField == 'email'
                  ? TextFormField(
                      initialValue: _tempEmail ?? email,
                      onChanged: (value) {
                        setState(() {
                          _tempEmail = value;
                        });
                      },
                      style: GoogleFonts.notoSansThai(
                        textStyle: const TextStyle(
                          color: Color(0xFF030260),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, bottom: 5),
                        labelText: 'Email',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _tempEmail ?? email,
                        style: GoogleFonts.notoSansThai(
                          textStyle: const TextStyle(
                            color: Color(0xFF030260),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            if (isEditing)
              IconButton(
                icon: const Icon(LineAwesomeIcons.edit, color: Colors.black),
                onPressed: () {
                  setState(() {
                    editedField = editedField == 'email' ? null : 'email';
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUsernameField(ThemeState state, String username) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: isEditing ? grayColor : const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.user, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                username,
                style: GoogleFonts.notoSansThai(
                  textStyle: const TextStyle(
                    color: Color(0xFF030260),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNameField(ThemeState state, String name) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.user_circle, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: isEditing && editedField == 'name'
                  ? TextFormField(
                      initialValue: _tempName ?? name,
                      onChanged: (value) {
                        setState(() {
                          _tempName = value;
                        });
                      },
                      style: GoogleFonts.notoSansThai(
                        textStyle: const TextStyle(
                          color: Color(0xFF030260),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 10, bottom: 5),
                        labelText: 'name',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                          fontSize: 12,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Text(
                        _tempName ?? name,
                        style: GoogleFonts.notoSansThai(
                          textStyle: const TextStyle(
                            color: Color(0xFF030260),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
            ),
            if (isEditing)
              IconButton(
                icon: const Icon(LineAwesomeIcons.edit, color: Colors.black),
                onPressed: () {
                  setState(() {
                    editedField = editedField == 'name' ? null : 'name';
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFacultyField(ThemeState state, String faculty) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: isEditing ? grayColor : const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.university_solid, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                'ไม่มีคณะ',
                style: GoogleFonts.notoSansThai(
                  textStyle: const TextStyle(
                    color: Color(0xFF030260),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPasswordField(ThemeState state, String password) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.fingerprint_solid, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                password,
                style: GoogleFonts.notoSansThai(
                  textStyle: const TextStyle(
                    color: Color(0xFF030260),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (isEditing)
              IconButton(
                icon: const Icon(LineAwesomeIcons.edit, color: Colors.black),
                onPressed: _showChangePasswordDialog,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                if (isEditing) {
                  _updateUserInfo();
                }
                setState(() {
                  isEditing = !isEditing;
                });
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                backgroundColor: Colors.black,
              ),
              child: Text(
                isEditing ? TextConstant.confirm : TextConstant.edit,
                style: GoogleFonts.notoSansThai(
                  textStyle: const TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ),
          if (isEditing) ...[
            const SizedBox(width: 10),
            Expanded(child: _buildCancelButton()),
          ],
        ],
      ),
    );
  }

  Widget _buildCancelButton() {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          isEditing = false;
          editedField = null;
          _tempEmail = null;
          _tempName = null;
        });
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: const Color.fromARGB(255, 143, 29, 29),
      ),
      child: Text(
        TextConstant.cancel,
        style: GoogleFonts.notoSansThai(
          textStyle: const TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return FractionallySizedBox(
      widthFactor: 0.70,
      child: ElevatedButton(
        onPressed: _logout,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: const Color(0xFF991616),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              LineAwesomeIcons.sign_out_alt_solid,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(width: 15),
            Text(
              TextConstant.logout,
              style: GoogleFonts.notoSansThai(
                textStyle: const TextStyle(
                  color: Color(0xFFFFFFFF),
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เปลี่ยนรหัสผ่าน'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'รหัสผ่านเก่า'),
                onChanged: (value) => _currentPassword = value,
              ),
              TextField(
                obscureText: true,
                decoration: const InputDecoration(labelText: 'รหัสผ่านใหม่'),
                onChanged: (value) => _newPassword = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text(TextConstant.cancel),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text(TextConstant.change),
              onPressed: () {
                if (_currentPassword != null && _newPassword != null) {
                  setState(() {
                    _tempNewPassword = _newPassword;
                    _tempCurrentPassword = _currentPassword;
                  });
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                          'รหัสผ่านถูกเปลี่ยนแล้ว กรุณากดยืนยันเพื่อบันทึกการเปลี่ยนแปลง'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _updateUserInfo() {
    final userState = context.read<UserBloc>().state;
    if (userState is ReadyUserState) {
      final currentUser = userState.user;
      context.read<UserBloc>().add(UpdateUserEvent(
            email: _tempEmail ?? currentUser.email ?? '',
            name: _tempName ?? currentUser.name ?? '',
            faculty: 'ไม่มีคณะ',
          ));

      if (_tempNewPassword != null && _tempCurrentPassword != null) {
        context.read<UserBloc>().add(ChangePasswordEvent(
              currentPassword: _tempCurrentPassword!,
              newPassword: _tempNewPassword!,
            ));
      }
    }

    SnackBarHelper.showSuccessSnackBar(
      context,
      title: 'อัปเดตสำเร็จ',
      message: 'ข้อมูลผู้ใช้งานได้รับการอัปเดตเรียบร้อยแล้ว',
    );

    setState(() {
      _tempEmail = null;
      _tempName = null;
      _tempCurrentPassword = null;
      _tempNewPassword = null;
      isEditing = false;
    });
  }

  void _logout() {
    context.read<UserBloc>().add(LogoutUserEvent());
    Navigator.of(context).pushReplacementNamed(loginPageRoute);
  }
}
