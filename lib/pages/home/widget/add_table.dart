import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddTable extends StatelessWidget {
  const AddTable({super.key});

  @override
  Widget build(BuildContext context) {
    var numberController = TextEditingController();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สร้างโต๊ะ', style: GoogleFonts.notoSansThai()),
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
                    style: GoogleFonts.notoSansThai(color: Colors.red),
                  ),
                  onPressed: () {
                    numberController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'สร้าง',
                    style: GoogleFonts.notoSansThai(color: Colors.green),
                  ),
                  onPressed: () {
                    context.read<TableBloc>().add(CreateTableEvent(
                          number: int.tryParse(numberController.text) ?? 0,
                          roomId: context.read<RoomBloc>().state.room.id,
                        ));
                    numberController.clear();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('กำลังสร้างโต๊ะ...')),
                    );
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
      backgroundColor: Colors.transparent,
      child: const Icon(
        Icons.table_restaurant,
        size: 20,
        color: Colors.black,
      ),
    );
  }
}
