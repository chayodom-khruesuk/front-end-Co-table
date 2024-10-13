import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core.dart';
import 'table_history.dart';

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const double boxHeight = 165;
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (context, state) {
        if (state is LoadingRoomState) {
          return const Center(child: CircularProgressIndicator());
        }

        final roomList = state.roomList;
        print('Room list in UI: $roomList');

        if (roomList.isEmpty) {
          return Center(
            child: Text(
              'ไม่พบห้องในระบบ',
              style: GoogleFonts.notoSansThai(),
            ),
          );
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height * 0.07),
          child: Column(
            children: roomList.map((room) {
              return Container(
                height: boxHeight,
                width: double.infinity,
                margin:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
                decoration: BoxDecoration(
                  gradient: ThemeState.lightTheme,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
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
                        room.name,
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
                                room.faculty,
                                style: GoogleFonts.notoSansThai(
                                  textStyle: const TextStyle(
                                    color: Color(0xFF030260),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              Text(
                                room.status ? 'เปิด' : 'ปิด',
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
                                      const TableHistory(boxName: 'Box'),
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
            }).toList(),
          ),
        );
      },
    );
  }
}
