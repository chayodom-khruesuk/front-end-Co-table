import 'package:co_table/bloc/widget/widget_bloc.dart';
import 'package:co_table/bloc/widget/widget_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchWidget extends StatelessWidget {
  const SearchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          hintText: 'Search....',
          hintStyle: const TextStyle(color: Colors.grey),
          prefixIcon: const Icon(
            Icons.search,
            color: Color(0xFF6E800E),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(40),
            borderSide: const BorderSide(color: Color(0xFFCEC108)),
          ),
        ),
        onChanged: (query) {
          if (query.isEmpty) {
            context.read<WidgetBloc>().add(SearchClearEvent());
          } else {
            context.read<WidgetBloc>().add(SearchRoomEvent(query));
          }
        },
      ),
    );
  }
}
