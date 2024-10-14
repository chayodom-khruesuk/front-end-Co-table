import 'package:co_table/models/models.dart';
import 'package:co_table/models/table_model.dart';
import 'package:co_table/repositories/table/table_repo.dart';
import 'package:co_table/services/services.dart';

class TableRepoDb extends TableRepo {
  late List<TableModel> tables = [];
  late TableModel tableModel;
  late TableModelList tableList;

  final ApiService apiService = ApiService();
  final String _baseUrl = '/tables';

  @override
  Future<String> createTable({
    required int number,
    required int roomId,
    required bool isAvailable,
  }) async {
    final response = await apiService.post('$_baseUrl/create_table', data: {
      'number': number,
      'room_id': roomId,
      'is_available': isAvailable
    });
    if (response.statusCode == 200) {
      return "Table created successfully";
    } else {
      throw Exception('Failed to create table');
    }
  }

  @override
  Future<List<TableModel>> getAllTable({int page = 1}) async {
    final response =
        await apiService.get('$_baseUrl/get_listTable', query: {'page': page});
    if (response.statusCode == 200) {
      final tableList = TableModelList.fromJson(response.data);
      tables = tableList.tables;
      return tables;
    } else {
      throw Exception('Failed to get all table');
    }
  }

  @override
  Future<TableModel> getTable() async {
    final response = await apiService.get('$_baseUrl/table_id');
    if (response.statusCode == 200) {
      return TableModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get table');
    }
  }

  @override
  Future<String> deleteTable({required int tableId}) async {
    final response = await apiService.delete(
      '$_baseUrl/delete_table',
    );
    if (response.statusCode == 200) {
      return 'Table deleted successfully';
    } else {
      throw Exception('Failed to delete table');
    }
  }

  @override
  Future<String> deleteAllTable({required int roomId}) async {
    final response = await apiService.delete(
      '$_baseUrl/del_table_in_room/$roomId',
    );
    if (response.statusCode == 200) {
      return 'Tables deleted successfully';
    } else {
      throw Exception('Failed to delete tables');
    }
  }

  @override
  Future<String> updateTable({
    required int tableId,
  }) async {
    final response = await apiService.put(
      '$_baseUrl/is_available/$tableId',
    );
    if (response.statusCode == 200) {
      return 'Table updated successfully';
    } else {
      throw Exception('Failed to update table');
    }
  }
}
