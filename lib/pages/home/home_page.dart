import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/pages/home/add_dialog.dart';
import 'package:co_table/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import '../../widget/search.dart';
import 'body_home_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<RoomBloc>().add(LoadRoomListEvent(page: 1));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        final isAdmin = userState is ReadyUserState &&
            userState.user.roles?.contains('admin') == true;
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
                              if (userState is ReadyUserState)
                                Text(userState.user.name ?? '',
                                    style: GoogleFonts.notoSansThai(
                                        textStyle: const TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.normal,
                                    ))),
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
                child: Column(
                  children: [
                    const SearchWidget(),
                    const SizedBox(height: 10),
                    if (isAdmin)
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          width: 40,
                          height: 40,
                          child: AddDialog(),
                        ),
                      ),
                    const SizedBox(height: 10),
                    const Expanded(child: BodyHomePage()),
                    const SizedBox(height: 50),
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
