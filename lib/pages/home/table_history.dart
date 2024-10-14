import 'package:co_table/utils/text_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:developer' as dev;

import '../../bloc/bloc.dart';
import '../../core.dart';
import '../../models/models.dart';
import 'table_each.dart';

class TableHistory extends StatelessWidget {
  final String boxName;

  const TableHistory({super.key, required this.boxName});

  @override
  Widget build(BuildContext context) {
    var numberController = TextEditingController();
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
                        )),
                  ),
                  leading: Container(
                    padding: const EdgeInsets.only(left: 25),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, size: 30),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                  actions: [
                    Container(
                      padding: const EdgeInsets.only(right: 5),
                      child: IconButton(
                        icon: Icon(
                          room.status ? Icons.lock_open : Icons.lock,
                          size: 30,
                          color: const Color(0xDF141414),
                        ),
                        onPressed: () {
                          context
                              .read<RoomBloc>()
                              .add(StatusRoomEvent(roomId: room.id));
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(right: 10),
                      child: FloatingActionButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('สร้างโต๊ะ',
                                    style: GoogleFonts.notoSansThai()),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(
                                      controller: numberController,
                                      style: GoogleFonts.notoSansThai(),
                                      decoration: InputDecoration(
                                        border: const OutlineInputBorder(),
                                        labelText: 'ระบุจำนวนโต๊ะ',
                                        labelStyle: GoogleFonts.notoSansThai(),
                                        hintText: 'เช่น 5',
                                        hintStyle: GoogleFonts.notoSansThai(),
                                      ),
                                    ),
                                  ],
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text(
                                      'ยกเลิก',
                                      style: GoogleFonts.notoSansThai(
                                          color: Colors.red),
                                    ),
                                    onPressed: () {
                                      numberController.clear();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text(
                                      'สร้าง',
                                      style: GoogleFonts.notoSansThai(
                                          color: Colors.green),
                                    ),
                                    onPressed: () {
                                      dev.log(room.id.toString());
                                      context
                                          .read<TableBloc>()
                                          .add(CreateTableEvent(
                                            number: (int.tryParse(
                                                    numberController.text) ??
                                                1),
                                            roomId: room.id,
                                            isAvailable: false,
                                          ));
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              );
                            },
                          ).then((_) {
                            numberController.clear();
                          });
                        },
                        elevation: 0,
                        backgroundColor: const Color(0xAAD535EE),
                        child: const Icon(
                          Icons.table_view,
                          size: 30,
                          color: Color(0xDF141414),
                        ),
                      ),
                    ),
                  ],
                  flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: ThemeState.appTheme,
                    ),
                  ),
                ),
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
                    Column(
                      children: [
                        _buildBoxHeader(context, room),
                        _buildBoxSelect(),
                        Expanded(
                          child: TableEach(roomId: room.id),
                        ),
                      ],
                    ),
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

  Widget _buildBoxHeader(BuildContext context, RoomModel room) {
    return Container(
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height * 0.05,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
      ),
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
      width: double.infinity,
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
              BlocBuilder<TableBloc, TableState>(
                builder: (context, tableState) {
                  final tableCount = tableState.tableList
                      .where((table) => table.roomId == room.id)
                      .length;
                  return Text(
                    "จำนวน $tableCount โต๊ะ",
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF040261),
                    ),
                  );
                },
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
    );
  }

  Widget _buildBoxSelect() {
    return Column(
      children: [
        const SizedBox(height: 20),
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
    );
  }
}
