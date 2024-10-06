import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/bloc/user/user_bloc.dart';
import 'package:co_table/pages/home/home_page.dart';
import 'package:co_table/pages/home/user/user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core.dart';
import '../pages/profile/profile_page.dart';
import '../pages/reservation/reservation_page.dart';

class NavWithAnimated extends StatefulWidget {
  const NavWithAnimated({super.key});

  @override
  State<NavWithAnimated> createState() => _NavWithAnimatedState();
}

class _NavWithAnimatedState extends State<NavWithAnimated> {
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    final isAdmin = context.read<UserBloc>().state.user.roles.contains('admin');
    final pages = [
      const HomePage(),
      const ReservationPage(),
      const ProfilePage(),
      if (isAdmin) const UserPage(),
    ];

    final List<IconData> navBarIcon =
        isAdmin ? listNavBarIconAdmin : listNavBarIcon;
    final List<String> navBarText =
        isAdmin ? listNavBarTextAdmin : listNavBarText;

    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: themeState.backgroundGradient,
            ),
            child: Stack(
              children: [
                IndexedStack(
                  index: currentIndex,
                  children: pages,
                ),
                if (!isKeyboardVisible)
                  Positioned(
                    left: displayWidth * .06,
                    right: displayWidth * .06,
                    bottom: displayWidth * .06,
                    child: Container(
                      height: displayWidth * .19,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(.3),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          navBarText.length,
                          (index) => SizedBox(
                            child: InkWell(
                              onTap: () {
                                setState(
                                  () {
                                    currentIndex = index;
                                    HapticFeedback.lightImpact();
                                  },
                                );
                              },
                              child: Stack(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == currentIndex
                                        ? (navBarText[index] == 'Reservation'
                                            ? displayWidth * .45
                                            : displayWidth * .4)
                                        : displayWidth * .18,
                                    alignment: Alignment.center,
                                    child: AnimatedContainer(
                                      duration: const Duration(seconds: 1),
                                      curve: Curves.fastLinearToSlowEaseIn,
                                      height: index == currentIndex
                                          ? displayWidth * .13
                                          : 0,
                                      width: index == currentIndex
                                          ? displayWidth * 1
                                          : 0,
                                      decoration: BoxDecoration(
                                        color: index == currentIndex
                                            ? ThemeState
                                                .defaultTheme.colors.first
                                            : ThemeState
                                                .lightTheme.colors.first,
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: const Duration(seconds: 1),
                                    curve: Curves.fastLinearToSlowEaseIn,
                                    width: index == currentIndex
                                        ? displayWidth * .4
                                        : displayWidth * .18,
                                    alignment: Alignment.center,
                                    child: Stack(
                                      children: [
                                        Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              width: index == currentIndex
                                                  ? displayWidth * .135
                                                  : 0,
                                            ),
                                            Flexible(
                                              child: AnimatedOpacity(
                                                opacity: index == currentIndex
                                                    ? 1
                                                    : 0,
                                                duration:
                                                    const Duration(seconds: 1),
                                                curve: Curves
                                                    .fastLinearToSlowEaseIn,
                                                child: Text(
                                                  index == currentIndex
                                                      ? navBarText[index]
                                                      : '',
                                                  style:
                                                      GoogleFonts.notoSansThai(
                                                    textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  overflow:
                                                      TextOverflow.visible,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            AnimatedContainer(
                                              duration:
                                                  const Duration(seconds: 1),
                                              curve:
                                                  Curves.fastLinearToSlowEaseIn,
                                              width: index == currentIndex
                                                  ? displayWidth * .03
                                                  : 30,
                                            ),
                                            Icon(
                                              size: displayWidth * .08,
                                              navBarIcon[index],
                                              color: index == currentIndex
                                                  ? ThemeState
                                                      .lightTheme.colors.first
                                                  : ThemeState.defaultTheme
                                                      .colors.first,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

List<String> listNavBarText = ['หน้าหลัก', 'การจอง', 'โปรไฟล์'];

List<String> listNavBarTextAdmin = [
  'หน้าหลัก',
  'การจอง',
  'โปรไฟล์',
  'จัดการผู้ใช้'
];

List<IconData> listNavBarIcon = [
  Icons.home,
  Icons.book,
  Icons.person,
];

List<IconData> listNavBarIconAdmin = [
  Icons.home,
  Icons.book,
  Icons.person,
  Icons.group,
];
