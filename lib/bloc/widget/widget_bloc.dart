import 'package:co_table/bloc/widget/widget_event.dart';
import 'package:co_table/bloc/widget/widget_state.dart';
import 'package:co_table/models/room_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WidgetBloc extends Bloc<WidgetEvent, WidgetState> {
  final List<RoomModel> allRooms;

  WidgetBloc({required this.allRooms})
      : super(InitialWidgetState(room: allRooms)) {
    on<SearchRoomEvent>(_onSearch);
    on<SearchClearEvent>(_onSearchClear);
  }

  void _onSearch(SearchRoomEvent event, Emitter<WidgetState> emit) async {
    final query = event.query.toLowerCase();
    final filteredRooms = allRooms
        .where((room) =>
            room.name.toLowerCase().contains(query) ||
            room.faculty.toLowerCase().contains(query))
        .toList();

    emit(SearchRoomState(query: query, room: filteredRooms));
  }

  void _onSearchClear(SearchClearEvent event, Emitter<WidgetState> emit) async {
    emit(InitialWidgetState(room: allRooms));
  }
}
