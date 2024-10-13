sealed class TableEvent {}

class LoadTableEvent extends TableEvent {}

class LoadTableListEvent extends TableEvent {
  final int page;
  LoadTableListEvent({this.page = 1});
}

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
