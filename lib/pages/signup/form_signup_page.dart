import 'package:co_table/router/routes_conf.dart';
import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core.dart';

class FormSignupPage extends StatefulWidget {
  const FormSignupPage({super.key});

  @override
  FormSignupPageState createState() => FormSignupPageState();
}

class FormSignupPageState extends State<FormSignupPage> {
  bool _showPassword = false;
  bool _showConfirmPassword = false;
  String _userType = 'general';
  String? _selectedFaculty;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: SizeConstant.defaultPadding * 12),
          const Text(TextConstant.headerSignup,
              style: TextStyle(fontSize: 35, fontWeight: FontWeight.w600)),
          const Text(TextConstant.lableSignup,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
          const SizedBox(height: SizeConstant.defaultPadding + 5),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 92, 91, 91).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
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
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 92, 91, 91).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                decoration: InputDecoration(
                  prefixIcon: const Icon(LineAwesomeIcons.earlybirds,
                      color: Colors.black),
                  labelText: TextConstant.textEmail,
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
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          const FractionallySizedBox(
            widthFactor: 0.8,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Type: ",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          SizedBox(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: Text('General',
                          style: TextStyle(
                              color: _userType == 'general'
                                  ? Colors.white
                                  : Colors.black)),
                      selected: _userType == 'general',
                      selectedColor: state.backgroundGradient.colors.first,
                      backgroundColor: Colors.white,
                      onSelected: (selected) {
                        setState(() {
                          _userType = 'general';
                        });
                      },
                    ),
                    const SizedBox(width: 30),
                    ChoiceChip(
                      label: Text('Educational',
                          style: TextStyle(
                              color: _userType == 'educational'
                                  ? Colors.white
                                  : Colors.black)),
                      selected: _userType == 'educational',
                      selectedColor: state.backgroundGradient.colors.first,
                      backgroundColor: Colors.white,
                      onSelected: (selected) {
                        setState(() {
                          _userType = 'educational';
                        });
                      },
                    ),
                  ],
                ),
                if (_userType == 'educational')
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedFaculty,
                            hint: const Text('Select Faculty'),
                            items: <String>[
                              'Engineering',
                              'Science',
                              'Arts',
                              'Medicine'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text('Faculty of $value'),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                _selectedFaculty = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 92, 91, 91).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: !_showPassword,
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
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
          FractionallySizedBox(
            widthFactor: 0.9,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color:
                        const Color.fromARGB(255, 92, 91, 91).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: TextFormField(
                obscureText: !_showConfirmPassword,
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
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _showConfirmPassword
                          ? LineAwesomeIcons.eye
                          : LineAwesomeIcons.eye_slash,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      setState(() {
                        _showConfirmPassword = !_showConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: SizeConstant.defaultPadding),
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
                TextConstant.signup,
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
                  TextConstant.textSignupFooter,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Padding(padding: EdgeInsets.all(5)),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(loginPageRoute);
                  },
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
          ),
        ],
      );
    });
  }
}
