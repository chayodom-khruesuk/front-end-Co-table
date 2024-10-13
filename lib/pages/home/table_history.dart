import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../bloc/bloc.dart';
import '../../core.dart';
import '../../models/models.dart';
import 'table_each.dart';

class TableHistory extends StatelessWidget {
  final String boxName;

  const TableHistory({super.key, required this.boxName});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, themeState) {
        return BlocBuilder<RoomBloc, RoomState>(
          builder: (context, roomState) {
            if (roomState is ReadyRoomState) {
              final room =
                  roomState.roomList.firstWhere((r) => r.name == boxName);
              return Scaffold(
                appBar: AppBar(
                    title: Center(
                        child: Text('$boxName Room',
                            style: GoogleFonts.poppins(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ))),
                    leading: Container(
                        padding: const EdgeInsets.only(left: 25),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, size: 30),
                          onPressed: () => Navigator.of(context).pop(),
                        )),
                    actions: [
                      Container(
                        padding: const EdgeInsets.only(right: 25),
                        child: IconButton(
                          icon: Icon(
                            room.status ? Icons.lock_open : Icons.lock,
                            size: 30,
                          ),
                          onPressed: () {
                            context
                                .read<RoomBloc>()
                                .add(StatusRoomEvent(roomId: room.id!));
                          },
                        ),
                      ),
                    ],
                    flexibleSpace: Container(
                        decoration: const BoxDecoration(
                      gradient: ThemeState.appTheme,
                    ))),
                body: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        gradient: ThemeState.appTheme,
                      ),
                      padding: const EdgeInsets.only(top: 100),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: ThemeState.lightTheme,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                      ),
                    ),
                    _buildBoxHeader(context, room),
                    _buildBoxSelect(),
                    const TableEach(),
                  ],
                ),
              );
            }
            return const CircularProgressIndicator();
          },
        );
      },
    );
  }

  Positioned _buildBoxHeader(BuildContext context, RoomModel room) {
    return Positioned(
      top: MediaQuery.of(context).size.height * 0.5 - 410,
      left: MediaQuery.of(context).size.width * 0.5 - 175,
      child: Container(
        decoration: BoxDecoration(
          gradient: ThemeState.lightTheme,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        width: 350,
        height: 140,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Padding(padding: EdgeInsets.only(left: 30)),
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
                const Spacer(),
                const Text(
                  "0/12 Tables",
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF040261),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 30)),
              ],
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(right: 70),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Open: 9.00 - 12.00 AM",
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFC01E13),
                    ),
                  ),
                  Text(
                    "กรุณาอย่าส่งเสียงดัง รบกวนผู้อื่น",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFAE0F2C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Positioned _buildBoxSelect() {
    return Positioned(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.only(top: 210)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD7D5D5),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 94, 93, 93),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(TextConstant.textAvailable,
                      style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF39B070),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 94, 93, 93),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(TextConstant.textSelected,
                      style: TextStyle(fontSize: 12)),
                ],
              ),
              Column(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: BoxDecoration(
                      color: const Color(0xFF040261),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(255, 94, 93, 93),
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(TextConstant.textBlocked,
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
