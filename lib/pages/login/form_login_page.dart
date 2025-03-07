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

class FormLoginPage extends StatefulWidget {
  const FormLoginPage({super.key});

  @override
  FormLoginPageState createState() => FormLoginPageState();
}

class FormLoginPageState extends State<FormLoginPage> {
  bool _showPassword = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState &&
            state.responseText == "เข้าสู่ระบบสำเร็จ") {
          Navigator.of(context).pushReplacementNamed(homePageRoute);
          SnackBarHelper.showSuccessSnackBar(
            context,
            title: 'แจ้งเตือนการเข้าสู่ระบบ',
            message: state.responseText,
            duration: const Duration(seconds: 3),
          );
        }
        if (state is UserEmptyState && state.responseText.isNotEmpty) {
          SnackBarHelper.showErrorSnackBar(
            context,
            title: 'แจ้งเตือนการเข้าสู่ระบบ',
            message: state.responseText,
            duration: const Duration(seconds: 3),
          );
        }
      },
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: SizeConstant.defaultPadding * 10),
                Text(
                  TextConstant.headerLogin,
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  TextConstant.lableLogin,
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: SizeConstant.defaultPadding + 20),
                _buildUsernameField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildPasswordField(state),
                const SizedBox(height: SizeConstant.defaultPadding - 15),
                _buildForgotPasswordButton(),
                _buildLoginButton(),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildSignupLink(state),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildUsernameField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          controller: _usernameController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user, color: Colors.black),
            labelText: TextConstant.textUsername,
            labelStyle: GoogleFonts.notoSansThai(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            fillColor: const Color(0xAAD93EF2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            errorStyle: GoogleFonts.notoSansThai(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาระบุชื่อบัญชีผู้ใช้ของคุณ';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildPasswordField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
        child: TextFormField(
          controller: _passwordController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          obscureText: !_showPassword,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.fingerprint_solid,
                color: Colors.black),
            labelText: TextConstant.textPassword,
            labelStyle: GoogleFonts.notoSansThai(
              textStyle: const TextStyle(
                color: Colors.black,
              ),
            ),
            fillColor: const Color(0xAAD93EF2),
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            errorStyle: GoogleFonts.notoSansThai(
              textStyle: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
            suffixIcon: IconButton(
              icon: Icon(
                  _showPassword
                      ? LineAwesomeIcons.eye
                      : LineAwesomeIcons.eye_slash,
                  color: Colors.black),
              onPressed: () => setState(() => _showPassword = !_showPassword),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาระบุรหัสผ่านของคุณ';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildForgotPasswordButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => Navigator.of(context).pushNamed(forgotPageRoute),
        child: Text(
          TextConstant.forgotPassword,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: _login,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.black,
        ),
        child: Text(
          TextConstant.login,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignupLink(ThemeState state) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TextConstant.textLoginFooter,
            style: GoogleFonts.notoSansThai(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 14,
              ),
            ),
          ),
          const Padding(padding: EdgeInsets.all(5)),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(signupPageRoute),
            child: Text(
              TextConstant.textLinkLoginFooter,
              style: GoogleFonts.notoSansThai(
                textStyle: TextStyle(
                  color: state.backgroundGradient.colors.first,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String password = _passwordController.text;
      context
          .read<UserBloc>()
          .add(LoginUserEvent(username: username, password: password));
      FocusScope.of(context).unfocus();
    } else {
      SnackBarHelper.showWarningSnackBar(
        context,
        title: 'กรอกข้อมูลไม่ครบถ้วน',
        message: 'กรุณากรอกข้อมูลให้ครบถ้วน',
        duration: const Duration(seconds: 3),
      );
    }
  }
}
