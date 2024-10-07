import 'package:co_table/models/models.dart';

sealed class WidgetState {
  final List<RoomModel> room;
  WidgetState({required this.room});
}

class InitialWidgetState extends WidgetState {
  InitialWidgetState({required super.room});
}

class SearchRoomState extends WidgetState {
  final String query;
  SearchRoomState({required this.query, required super.room});
}
