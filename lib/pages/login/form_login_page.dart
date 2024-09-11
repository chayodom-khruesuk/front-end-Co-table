import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../bloc/bloc.dart';

class FormLoginPage extends StatefulWidget {
  const FormLoginPage({super.key});

  @override
  FormLoginPageState createState() => FormLoginPageState();
}

class FormLoginPageState extends State<FormLoginPage> {
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SizeConstant.defaultPadding * 6),
          const Text(TextConstant.headerLogin,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
          const Text(TextConstant.lableLogin,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500)),
          const SizedBox(height: SizeConstant.defaultPadding + 20),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextFormField(
              decoration: InputDecoration(
                prefixIcon:
                    const Icon(LineAwesomeIcons.user, color: Colors.black),
                labelText: TextConstant.textUsername,
                labelStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                fillColor: state.backgroundGradient.colors.first,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
              ),
            ),
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: TextFormField(
              obscureText: !_showPassword,
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  LineAwesomeIcons.fingerprint_solid,
                  color: Colors.black,
                ),
                labelText: TextConstant.textPassword,
                labelStyle: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.w700),
                fillColor: state.backgroundGradient.colors.first,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword
                        ? LineAwesomeIcons.eye
                        : LineAwesomeIcons.eye_slash,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: SizeConstant.defaultPadding - 15),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.of(context).pushNamed(forgotPageRoute),
              child: const Text(
                TextConstant.forgotPassword,
                style: TextStyle(color: Colors.red),
              ),
            ),
          ),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: ElevatedButton(
              onPressed: () => Navigator.of(context).pushNamed(homePageRoute),
              style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  backgroundColor: Colors.black),
              child: const Text(
                TextConstant.login,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  TextConstant.textLoginFooter,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(signupPageRoute);
                  },
                  child: Text(
                    TextConstant.textLinkFooter,
                    style: TextStyle(
                      color: state.backgroundGradient.colors.first,
                      fontSize: 13.5,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
