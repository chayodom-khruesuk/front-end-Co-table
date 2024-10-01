import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          Navigator.of(context).pushReplacementNamed(homePageRoute);
          SnackBarHelper.showSuccessSnackBar(
            context,
            title: 'Signup Complete',
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
                const Text(TextConstant.headerSignup,
                    style:
                        TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
                const Text(TextConstant.lableSignup,
                    style:
                        TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E6E6E).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: _usernameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user, color: Colors.black),
            labelText: TextConstant.textUsername,
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
              return 'Please enter your name';
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E6E6E).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: TextFormField(
          controller: _nameController,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.user_circle_solid,
                color: Colors.black),
            labelText: TextConstant.textName,
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
              return 'Please enter your username';
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E6E6E).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          controller: _emailController,
          decoration: InputDecoration(
            prefixIcon:
                const Icon(LineAwesomeIcons.envelope, color: Colors.black),
            labelText: TextConstant.textEmail,
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
              return 'Please enter your e-mail';
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E6E6E).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          obscureText: !_showPassword,
          controller: _passwordController,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.fingerprint_solid,
                color: Colors.black),
            labelText: TextConstant.textPassword,
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
              return 'Please enter your password';
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
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF6E6E6E).withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: TextFormField(
          obscureText: !_showConfirmPassword,
          controller: _confirmPasswordController,
          decoration: InputDecoration(
            prefixIcon: const Icon(LineAwesomeIcons.fingerprint_solid,
                color: Colors.black),
            labelText: TextConstant.textConfirmPassword,
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
              return 'Please enter your confirm password';
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
        child: const Text(TextConstant.signup,
            style: TextStyle(color: Colors.white, fontSize: 20)),
      ),
    );
  }

  Widget _buildLoginLink(ThemeState state) {
    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(TextConstant.textSignupFooter,
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
          title: 'Password Mismatch',
          message: 'Password and Confirm Password do not match.',
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
        title: 'Incomplete Form',
        message: 'Please fill in all required fields.',
        duration: const Duration(seconds: 3),
      );
    }
  }
}
