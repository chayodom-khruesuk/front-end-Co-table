import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../bloc/bloc.dart';
import '../../core.dart';
import '../../router/routes_conf.dart';
import '../../utils/helper/helper_func.dart';

class FormForgotPage extends StatefulWidget {
  const FormForgotPage({super.key});

  @override
  FormForgotPageState createState() => FormForgotPageState();
}

class FormForgotPageState extends State<FormForgotPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is LoadingUserState && state.responseText.isNotEmpty) {
          Navigator.of(context).pushReplacementNamed(loginPageRoute);
          SnackBarHelper.showSuccessSnackBar(
            context,
            title: 'สร้างรหัสผ่านใหม่สำเร็จ',
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
                const SizedBox(height: SizeConstant.defaultPadding * 5),
                const Text(TextConstant.headerForgot,
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
                const Text(TextConstant.lableForgot,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(height: SizeConstant.defaultPadding + 20),
                _buildEmailField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildNewPasswordField(state),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildSubmitButton(),
                const SizedBox(height: SizeConstant.defaultPadding),
                _buildSubmitLink(state),
              ],
            ),
          );
        },
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
          decoration: InputDecoration(
            prefixIcon:
                const Icon(LineAwesomeIcons.envelope, color: Colors.black),
            labelText: TextConstant.textEmail,
            labelStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w700,
            ),
            fillColor: state.backgroundGradient.colors.first,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            errorStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณากรอกอีเมล';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildNewPasswordField(ThemeState state) {
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
          controller: _newPasswordController,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.fingerprint_solid,
                color: Colors.black),
            labelText: TextConstant.textNewPassword,
            labelStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.w700),
            fillColor: state.backgroundGradient.colors.first,
            filled: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide.none,
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
            errorStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'กรุณาใส่รหัสผ่านใหม่';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: _submit,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          backgroundColor: Colors.black,
        ),
        child: const Text(TextConstant.submit,
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Widget _buildSubmitLink(ThemeState state) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(TextConstant.textForgotFooter,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 13.5,
                  fontWeight: FontWeight.bold)),
          const Padding(padding: EdgeInsets.all(5)),
          GestureDetector(
            onTap: () =>
                Navigator.of(context).pushReplacementNamed(loginPageRoute),
            child: Text(
              TextConstant.textLinkSignupFooter,
              style: TextStyle(
                color: state.backgroundGradient.colors.first,
                fontSize: 13.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String newPassword = _newPasswordController.text;
      context
          .read<UserBloc>()
          .add(ForgotPasswordEvent(email: email, newPassword: newPassword));
      FocusScope.of(context).unfocus();
    } else {
      SnackBarHelper.showWarningSnackBar(
        context,
        title: 'ข้อมูลไม่ถูกต้อง',
        message: 'กรุณากรอกข้อมูลให้ถูกต้อง',
        duration: const Duration(seconds: 3),
      );
    }
  }
}
