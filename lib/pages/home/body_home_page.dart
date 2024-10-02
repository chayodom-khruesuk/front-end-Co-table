import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
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
              margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
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
                    Text(
                      'Room Name',
                      style: GoogleFonts.notoSansThai(
                        textStyle: const TextStyle(
                          color: Color(0xFF030260),
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ชื่อคณะ',
                              style: GoogleFonts.notoSansThai(
                                textStyle: const TextStyle(
                                  color: Color(0xFF030260),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              'Room Name',
                              style: GoogleFonts.notoSansThai(
                                textStyle: const TextStyle(
                                  color: Color(0xFF959494),
                                  fontSize: 10,
                                ),
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
                              color: const Color(0xAAD93EF2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Center(
                              child: Text(
                                'จอง',
                                style: GoogleFonts.notoSansThai(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF030260),
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'สถานะ',
                              style: GoogleFonts.notoSansThai(
                                textStyle: const TextStyle(
                                  color: Color(0xFF030260),
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            Text(
                              'Room Name',
                              style: GoogleFonts.notoSansThai(
                                textStyle: const TextStyle(
                                  color: Color(0xFF959494),
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.only(right: 4),
                          child: Text(
                            '0 / 24 โต๊ะ',
                            style: GoogleFonts.notoSansThai(
                              textStyle: const TextStyle(
                                color: Color(0xFF030260),
                                fontSize: 12.26,
                              ),
                            ),
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
