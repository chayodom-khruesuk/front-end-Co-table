import 'package:flutter/material.dart';
import '../../core.dart';
import 'table_history.dart';

class BodyHomePage extends StatelessWidget {
  final int numberOfBoxes;

  const BodyHomePage({super.key, this.numberOfBoxes = 3});

  @override
  Widget build(BuildContext context) {
    const double boxHeight = 165;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.13),
      child: Column(
        children: [
          ...List.generate(numberOfBoxes, (index) {
            return Container(
              height: boxHeight,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                gradient: ThemeState.lightTheme,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Room Name',
                      style: TextStyle(
                        color: Color(0xFF030260),
                        fontSize: 20,
                        fontFamily: 'Noto Sans Thai',
                        fontWeight: FontWeight.w700,
                        shadows: [
                          Shadow(
                            blurRadius: 10,
                            color: Colors.grey,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 30,
                          height: 30,
                          decoration: ShapeDecoration(
                            color: const Color(0xAAD93EF2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ชื่อคณะ',
                              style: TextStyle(
                                color: Color(0xFF030260),
                                fontSize: 14,
                                fontFamily: 'Noto Sans Thai',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Room Name',
                              style: TextStyle(
                                color: Color(0xFF959494),
                                fontSize: 10,
                                fontFamily: 'Noto Sans Thai',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    TableHistory(boxName: 'Box ${index + 1}'),
                              ),
                            );
                          },
                          child: Container(
                            width: 100,
                            height: 36,
                            decoration: ShapeDecoration(
                              color: const Color(0xFFD93EF2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: const Center(
                              child: Text(
                                'Reservation',
                                style: TextStyle(
                                  color: Color(0xFF030260),
                                  fontSize: 14,
                                  fontFamily: 'Noto Sans Thai',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          width: 31,
                          height: 28,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFD9D9D9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          ),
                        ),
                        const SizedBox(width: 9),
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Status Room',
                              style: TextStyle(
                                color: Color(0xFF030260),
                                fontSize: 14,
                                fontFamily: 'Noto Sans Thai',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Text(
                              'Room Name',
                              style: TextStyle(
                                color: Color(0xFF959494),
                                fontSize: 10,
                                fontFamily: 'Noto Sans Thai',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        const Text(
                          '0 / 24 Tables',
                          style: TextStyle(
                            color: Color(0xFF030260),
                            fontSize: 12.26,
                            fontFamily: 'Noto Sans Thai',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
