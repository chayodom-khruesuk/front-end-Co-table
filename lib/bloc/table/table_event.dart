sealed class TableEvent {}

class LoadTableEvent extends TableEvent {}

class CreateTableEvent extends TableEvent {
  final int number;
  final int roomId;
  CreateTableEvent({required this.number, required this.roomId});
}

class GetTableEvent extends TableEvent {
  final int tableId;
  GetTableEvent({required this.tableId});
}

class DeleteTableEvent extends TableEvent {
  final int tableId;
  DeleteTableEvent({required this.tableId});
}
