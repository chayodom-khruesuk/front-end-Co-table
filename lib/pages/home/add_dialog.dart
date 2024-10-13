import 'package:co_table/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddDialog extends StatelessWidget {
  const AddDialog({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    return FloatingActionButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('สร้างห้อง', style: GoogleFonts.notoSansThai()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    style: GoogleFonts.notoSansThai(),
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(),
                      labelText: 'ชื่อห้อง',
                      labelStyle: GoogleFonts.notoSansThai(),
                      hintText: 'ระบุชื่อห้อง',
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
                    nameController.clear();
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: Text(
                    'สร้าง',
                    style: GoogleFonts.notoSansThai(color: Colors.green),
                  ),
                  onPressed: () {
                    context.read<RoomBloc>().add(CreateRoomEvent(
                          name: nameController.text,
                        ));
                    nameController.clear();
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('กำลังสร้างห้อง...')),
                    );
                  },
                )
              ],
            );
          },
        ).then((_) {
          nameController.clear();
        });
      },
      backgroundColor: const Color(0xAAD93EF2),
      child: const Icon(
        Icons.add,
        size: 20,
        color: Colors.white,
      ),
    );
  }
}
