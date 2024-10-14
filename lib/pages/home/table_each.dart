import 'package:co_table/bloc/reservation/reservation_bloc.dart';
import 'package:co_table/bloc/reservation/reservation_event.dart';
import 'package:co_table/bloc/reservation/reservation_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:developer' as dev;

import '../../bloc/bloc.dart';

class TableEach extends StatelessWidget {
  final int roomId;
  const TableEach({super.key, required this.roomId});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TableBloc, TableState>(
      builder: (context, tableState) {
        if (tableState is ReadyTableState) {
          final tableList = tableState.tableList
              .where((table) => table.roomId == roomId)
              .toList();
          return _TableEachContent(boxCount: tableList.length, roomId: roomId);
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

class _TableEachContent extends StatefulWidget {
  final int boxCount;
  final int roomId;

  const _TableEachContent({required this.boxCount, required this.roomId});

  @override
  _TableEachContentState createState() => _TableEachContentState();
}

class _TableEachContentState extends State<_TableEachContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 30, left: 40, right: 40, bottom: 90),
            child: GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: widget.boxCount,
              itemBuilder: (context, index) {
                return _buildBoxItem(index);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBoxItem(int index) {
    var hoursController = TextEditingController();
    return BlocBuilder<UserBloc, UserState>(builder: (context, userState) {
      return BlocBuilder<RoomBloc, RoomState>(
        builder: (context, roomState) {
          if (roomState is ReadyRoomState) {
            final room =
                roomState.roomList.firstWhere((r) => r.id == widget.roomId);
            return BlocBuilder<TableBloc, TableState>(
                builder: (context, tableState) {
              final tableList = tableState.tableList
                  .where((table) => table.roomId == room.id)
                  .toList();
              tableList.sort((a, b) => a.id.compareTo(b.id));
              dev.log(tableList.toString());
              final table = tableList[index];
              return BlocBuilder<ReservationBloc, ReservationState>(
                builder: (context, reservationState) {
                  bool isReserved = !table.isAvailable;
                  if (reservationState is ReadyReservationState) {
                    isReserved = reservationState.reservationList
                        .any((res) => res.tableId == table.id);
                  }
                  return GestureDetector(
                    onTap: isReserved
                        ? null
                        : () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                dev.log({table.id}.toString());
                                return AlertDialog(
                                  title: const Text('จองโต๊ะ'),
                                  content: TextField(
                                    controller: hoursController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly
                                    ],
                                    decoration: const InputDecoration(
                                      labelText: 'จำนวนชั่วโมง',
                                    ),
                                  ),
                                  actions: <Widget>[
                                    TextButton(
                                      child: const Text('ยกเลิก'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: const Text('จอง'),
                                      onPressed: () {
                                        context.read<ReservationBloc>().add(
                                              CreateReservationEvent(
                                                durationHours: int.parse(
                                                    hoursController.text),
                                                userId: userState.user.id,
                                                tableId: table.id,
                                              ),
                                            );
                                        context
                                            .read<TableBloc>()
                                            .add(UpdateTableEvent(
                                              tableId: table.id,
                                              isAvailable: false,
                                            ));
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: isReserved
                            ? const Color(0xFF040261)
                            : Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isReserved ? Colors.white : Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            });
          }
          return Container();
        },
      );
    });
  }
}
