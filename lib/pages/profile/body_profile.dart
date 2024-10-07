import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  BodyProfileState createState() => BodyProfileState();
}

class BodyProfileState extends State<BodyProfile> {
  bool isEditing = false;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themestate) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, userstate) {
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
                      _buildEmailField(themestate, userstate.user.email),
                      const SizedBox(height: SizeConstant.defaultPadding),
                      _buildUsernameField(themestate, userstate.user.username),
                      const SizedBox(height: SizeConstant.defaultPadding),
                      _buildNameField(themestate, userstate.user.name),
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.envelope, color: Colors.black),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                email,
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
              const Icon(LineAwesomeIcons.edit, color: Colors.black),
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
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.user, color: Colors.black),
            const SizedBox(width: 15),
            Text(
              username,
              style: GoogleFonts.notoSansThai(
                textStyle: const TextStyle(
                  color: Color(0xFF030260),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.user_circle, color: Colors.black),
            const SizedBox(width: 15),
            Text(
              name,
              style: GoogleFonts.notoSansThai(
                textStyle: const TextStyle(
                  color: Color(0xFF030260),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
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
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xAAD93EF2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            const Icon(LineAwesomeIcons.fingerprint_solid, color: Colors.black),
            const SizedBox(width: 15),
            Text(
              password,
              style: GoogleFonts.notoSansThai(
                textStyle: const TextStyle(
                  color: Color(0xFF030260),
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: () {
          setState(() {
            isEditing = !isEditing;
          });
        },
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.black,
        ),
        child: const Text(TextConstant.edit,
            style: TextStyle(color: Colors.white, fontSize: 20)),
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LineAwesomeIcons.sign_out_alt_solid,
              color: Colors.white,
              size: 30,
            ),
            SizedBox(width: 15),
            Text(
              TextConstant.logout,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  void _logout() {
    context.read<UserBloc>().add(LogoutUserEvent());
    Navigator.of(context).pushReplacementNamed(loginPageRoute);
  }
}
