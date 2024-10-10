import 'package:co_table/models/models.dart';

abstract class TableRepo {
  Future<String> createTable({
    required int number,
    required int roomId,
  });

  Future<TableModel> getTable();

  Future<List<TableModel>> getAllTable({int page = 1});

  Future<String> deleteTable({required int tableId});
}
