import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../bloc/bloc.dart';
import '../../core.dart';
import '../../utils/helper/helper_func.dart';

class FormSignupPage extends StatefulWidget {
  const FormSignupPage({super.key});

  @override
  FormSignupPageState createState() => FormSignupPageState();
}

class FormSignupPageState extends State<FormSignupPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState && state.responseText.isNotEmpty) {
          if (state.responseText == "User created successfully") {
            Navigator.of(context).pushReplacementNamed(homePageRoute);
            SnackBarHelper.showSuccessSnackBar(
              context,
              title: 'สมัครสมาชิกสำเร็จ',
              message: state.responseText,
              duration: const Duration(seconds: 3),
            );
          } else {
            SnackBarHelper.showErrorSnackBar(
              context,
              title: 'สมัครสมาชิกไม่สำเร็จ',
              message: state.responseText,
              duration: const Duration(seconds: 3),
            );
          }
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
                  TextConstant.headerSignup,
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(
                        fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  TextConstant.lableSignup,
                  style: GoogleFonts.notoSansThai(
                    textStyle: const TextStyle(
                        fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(height: SizeConstant.defaultPadding + 20),
                _buildUsernameField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildNameField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildEmailField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildPasswordField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildConfirmPasswordField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildSignupButton(),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildLoginLink(state),
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF6E6E6E).withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
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
                  fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอกชื่อผู้ใช้ของคุณ';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildNameField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF6E6E6E).withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 2),
          //   ),
          // ],
        ),
        child: TextFormField(
          controller: _nameController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user_circle_solid,
                color: Colors.black),
            labelText: TextConstant.textName,
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
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอกชื่อบัญชีผู้ใช้ของคุณ';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildEmailField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF6E6E6E).withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: TextFormField(
          controller: _emailController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon:
                const Icon(LineAwesomeIcons.envelope, color: Colors.black),
            labelText: TextConstant.textEmail,
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
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอกอีเมลของคุณ';
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
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF6E6E6E).withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: TextFormField(
          obscureText: !_showPassword,
          controller: _passwordController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
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
              return 'กรุณากรอกรหัสผ่านของคุณ';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildConfirmPasswordField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          // boxShadow: [
          //   BoxShadow(
          //     color: const Color(0xFF6E6E6E).withOpacity(0.5),
          //     spreadRadius: 2,
          //     blurRadius: 5,
          //     offset: const Offset(0, 3),
          //   ),
          // ],
        ),
        child: TextFormField(
          obscureText: !_showConfirmPassword,
          controller: _confirmPasswordController,
          style: GoogleFonts.notoSansThai(
            textStyle: const TextStyle(
              color: Colors.black,
            ),
          ),
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.fingerprint_solid,
                color: Colors.black),
            labelText: TextConstant.textConfirmPassword,
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
                  _showConfirmPassword
                      ? LineAwesomeIcons.eye
                      : LineAwesomeIcons.eye_slash,
                  color: Colors.black),
              onPressed: () =>
                  setState(() => _showConfirmPassword = !_showConfirmPassword),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอกยืนยันรหัสผ่าน';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSignupButton() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: _signup,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.black,
        ),
        child: Text(
          TextConstant.signup,
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

  Widget _buildLoginLink(ThemeState state) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            TextConstant.textSignupFooter,
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
                Navigator.of(context).pushReplacementNamed(loginPageRoute),
            child: Text(
              TextConstant.textLinkSignupFooter,
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

  void _signup() {
    if (_formKey.currentState!.validate()) {
      String username = _usernameController.text;
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      String confirmPassword = _confirmPasswordController.text;

      if (password != confirmPassword) {
        SnackBarHelper.showErrorSnackBar(
          context,
          title: 'รหัสผ่านไม่ตรงกัน',
          message: 'รหัสผ่านกับยืนยันรหัสผ่านไม่ตรงกัน',
          duration: const Duration(seconds: 3),
        );
        return;
      }
      context.read<UserBloc>().add(CreateUserEvent(
          username: username, name: name, email: email, password: password));
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
