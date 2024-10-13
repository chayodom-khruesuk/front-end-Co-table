import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core.dart';
import 'table_history.dart';

class BodyHomePage extends StatelessWidget {
  final bool isDeleteMode;

  const BodyHomePage({super.key, required this.isDeleteMode});

  @override
  Widget build(BuildContext context) {
    const double boxHeight = 165;

    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        final isAdmin = state.user.roles?.contains('admin') ?? false;

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: BlocConsumer<RoomBloc, RoomState>(
            listener: (context, state) {
              if (state is LoadingRoomState) {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (BuildContext context) {
                    return const Center(child: CircularProgressIndicator());
                  },
                );
                Future.delayed(const Duration(seconds: 1), () {
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                });
              }
              if (state is ReadyRoomState && state.responseText.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.responseText)),
                );
              }
            },
            builder: (context, state) {
              final roomList = state.roomList;
              return SingleChildScrollView(
                padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.07),
                child: Column(
                  children: roomList.map((room) {
                    return GestureDetector(
                      onTap: isDeleteMode
                          ? () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('ยืนยันการลบห้อง'),
                                    content: Text(
                                        'คุณต้องการลบห้อง ${room.name} ใช่หรือไม่?'),
                                    actions: <Widget>[
                                      TextButton(
                                        child: const Text('ยกเลิก'),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                      TextButton(
                                        child: const Text('ลบ'),
                                        onPressed: () {
                                          context.read<RoomBloc>().add(
                                              DeleteRoomEvent(roomId: room.id));
                                          Navigator.of(context).pop();
                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          : null,
                      child: Container(
                        height: boxHeight,
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 12),
                        decoration: BoxDecoration(
                          gradient: room.status
                              ? ThemeState.lightTheme
                              : const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    Color(0xFFE0E0E0),
                                    Color(0xFFC0C0C0)
                                  ],
                                ),
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
                                '${room.name} room',
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
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(room.faculty,
                                          style: GoogleFonts.notoSansThai(
                                              textStyle: const TextStyle(
                                            color: Color(0xFF030260),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ))),
                                    ],
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: (room.status) ||
                                            isAdmin //&& !isRoomFull(room)
                                        ? () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    TableHistory(
                                                        boxName: room.name),
                                              ),
                                            );
                                          }
                                        : null,
                                    child: Container(
                                      width: 100,
                                      height: 36,
                                      decoration: ShapeDecoration(
                                        color: (room.status) ||
                                                isAdmin //&& !isRoomFull(room)
                                            ? const Color(0xAAD93EF2)
                                            : Colors.grey,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'จอง',
                                          style: GoogleFonts.notoSansThai(
                                            textStyle: TextStyle(
                                              color: (room.status) ||
                                                      isAdmin //&& !isRoomFull(room)
                                                  ? const Color(0xFF030260)
                                                  : Colors.white54,
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
                                      color: room.status
                                          ? const Color.fromARGB(
                                              255, 76, 243, 76)
                                          : const Color.fromARGB(
                                              255, 241, 45, 45),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                    ),
                                  ),
                                  const SizedBox(width: 9),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'สถานะ',
                                        style: GoogleFonts.notoSansThai(
                                          textStyle: const TextStyle(
                                            color: Color(0xFF030260),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                      Text(room.status ? 'ห้องเปิด' : 'ห้องปิด',
                                          style: GoogleFonts.notoSansThai(
                                              textStyle: TextStyle(
                                            color: room.status
                                                ? Colors.green
                                                : Colors.red,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ))),
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
                                          fontSize: 13,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
