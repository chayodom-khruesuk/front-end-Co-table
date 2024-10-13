import '../../models/models.dart';

sealed class TableState {
  final TableModel table;
  final List<TableModel> tableList;
  final String responseText;
  TableState({
    required this.table,
    required this.tableList,
    this.responseText = '',
  });
}

const List<TableModel> emptyTableList = [];

class LoadingTableState extends TableState {
  LoadingTableState({super.responseText})
      : super(table: TableModel.empty(), tableList: emptyTableList);
}

class ReadyTableState extends TableState {
  final int currentPage;
  final bool isDataLoaded;

  ReadyTableState({
    required super.table,
    required super.tableList,
    this.currentPage = 0,
    this.isDataLoaded = false,
    super.responseText = '',
  });
}
