import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/pages/home/user/body_user_page.dart';
import 'package:co_table/utils/image_constant.dart';
import 'package:co_table/widget/search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Image.asset(
                        ImageConstant.headerImg,
                        height: 60,
                        fit: BoxFit.contain,
                        alignment: Alignment.centerLeft,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Row(
                            children: [
                              Text(
                                state.user.name,
                                style: GoogleFonts.notoSansThai(
                                  textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                              const SizedBox(width: 5),
                              const Icon(LineAwesomeIcons.user, size: 24),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                  left: 36,
                  top: 28,
                  right: 36,
                ),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: const Column(
                  children: [
                    SearchWidget(),
                    SizedBox(height: 10),
                    Expanded(child: BodyUserPage()),
                    SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
