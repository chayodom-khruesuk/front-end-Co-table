import '../../models/models.dart';

sealed class RoomState {
  final RoomModel room;
  final List<RoomModel> roomList;
  final String responseText;
  RoomState({
    required this.room,
    required this.roomList,
    this.responseText = '',
  });
}

const List<RoomModel> emptyRoomList = [];

class LoadingRoomState extends RoomState {
  LoadingRoomState({super.responseText})
      : super(room: RoomModel.empty(), roomList: emptyRoomList);
}

class ReadyRoomState extends RoomState {
  final int currentPage;
  final bool isDataLoaded;

  ReadyRoomState({
    required super.room,
    required super.roomList,
    this.currentPage = 0,
    this.isDataLoaded = false,
    super.responseText = '',
  });
}
