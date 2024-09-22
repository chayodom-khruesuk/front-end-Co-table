import 'package:co_table/bloc/bloc.dart';
import 'package:co_table/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../pages/profile/profile_page.dart';
import '../pages/reservation/reservation_page.dart';

class NavWithAnimated extends StatefulWidget {
  const NavWithAnimated({super.key});

  @override
  State<NavWithAnimated> createState() => _NavWithAnimatedState();
}

class _NavWithAnimatedState extends State<NavWithAnimated> {
  var currentIndex = 0;

  final pages = [
    const HomePage(),
    const ReservationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    double displayWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.all(displayWidth * .06),
        height: displayWidth * .19,
        decoration: BoxDecoration(
          gradient: ThemeState.lightTheme,
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
            3,
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
                          ? (listNavBarText[index] == 'Reservation'
                              ? displayWidth * .45
                              : displayWidth * .4)
                          : displayWidth * .18,
                      alignment: Alignment.center,
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        height: index == currentIndex ? displayWidth * .13 : 0,
                        width: index == currentIndex ? displayWidth * 1 : 0,
                        decoration: BoxDecoration(
                          color: index == currentIndex
                              ? ThemeState.defualtTheme.colors.first
                              : ThemeState.lightTheme.colors.first,
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
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .135
                                    : 0,
                              ),
                              Flexible(
                                child: AnimatedOpacity(
                                  opacity: index == currentIndex ? 1 : 0,
                                  duration: const Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    index == currentIndex
                                        ? listNavBarText[index]
                                        : '',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 16.5,
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                curve: Curves.fastLinearToSlowEaseIn,
                                width: index == currentIndex
                                    ? displayWidth * .03
                                    : 30,
                              ),
                              Icon(listNavBarIcon[index],
                                  size: displayWidth * .08,
                                  color: index == currentIndex
                                      ? ThemeState.lightTheme.colors.first
                                      : ThemeState.defualtTheme.colors.first),
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
    );
  }
}

List<String> listNavBarText = [
  'Home',
  'Reservation',
  'Profile',
];

List<IconData> listNavBarIcon = [
  Icons.home,
  Icons.book,
  Icons.person,
];
