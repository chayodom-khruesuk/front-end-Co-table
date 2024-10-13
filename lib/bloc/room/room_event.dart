sealed class RoomEvent {}

class LoadRoomEvent extends RoomEvent {}

class LoadRoomListEvent extends RoomEvent {
  final int page;
  LoadRoomListEvent({this.page = 1});
}

class CreateRoomEvent extends RoomEvent {
  final String name;
  final String? faculty;
  final bool status;
  CreateRoomEvent({required this.name, this.faculty, this.status = true});
}

class GetRoomEvent extends RoomEvent {
  final int roomId;
  GetRoomEvent({required this.roomId});
}

class UpdateRoomEvent extends RoomEvent {
  final int roomId;
  final String name;
  final String? faculty;
  UpdateRoomEvent({required this.roomId, required this.name, this.faculty});
}

class DeleteRoomEvent extends RoomEvent {
  final int roomId;
  DeleteRoomEvent({required this.roomId});
}

class StatusRoomEvent extends RoomEvent {
  final int roomId;
  StatusRoomEvent({required this.roomId});
}
