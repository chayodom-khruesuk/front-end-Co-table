import 'package:co_table/models/models.dart';

abstract class TableRepo {
  Future<String> createTable({required int number, required int roomId});

  Future<TableModel> getTable();

  Future<void> deleteTable({required int id});
}
