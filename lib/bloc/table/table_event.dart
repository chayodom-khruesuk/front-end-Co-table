sealed class TableEvent {}

class LoadTableEvent extends TableEvent {}

class LoadTableListEvent extends TableEvent {
  final int page;
  LoadTableListEvent({this.page = 1});
}

class CreateTableEvent extends TableEvent {
  final int number;
  final int roomId;
  final bool isAvailable;
  CreateTableEvent(
      {required this.number, required this.roomId, required this.isAvailable});
}

class GetTableEvent extends TableEvent {
  final int tableId;
  GetTableEvent({required this.tableId});
}

class DeleteTableEvent extends TableEvent {
  final int tableId;
  DeleteTableEvent({required this.tableId});
}

class UpdateTableEvent extends TableEvent {
  final int tableId;
  UpdateTableEvent({
    required this.tableId,
  });
}
