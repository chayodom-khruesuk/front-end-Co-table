import 'package:co_table/utils/size_constant.dart';
import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../core.dart';

class BodyProfile extends StatefulWidget {
  const BodyProfile({super.key});

  @override
  BodyProfileState createState() => BodyProfileState();
}

class BodyProfileState extends State<BodyProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          margin: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPasswordField(state),
              const SizedBox(height: SizeConstant.defaultPadding),
              _buildPasswordField(state),
              const SizedBox(height: SizeConstant.defaultPadding),
              _buildPasswordField(state),
              const SizedBox(height: SizeConstant.defaultPadding),
              _buildPasswordField(state),
              const SizedBox(height: SizeConstant.defaultPadding),
              _buildEditButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPasswordField(ThemeState state) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextFormField(
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
          ),
        ),
      ),
    );
  }

  Widget _buildEditButton() {
    return FractionallySizedBox(
      widthFactor: 0.9,
      child: ElevatedButton(
        onPressed: () {},
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
}
