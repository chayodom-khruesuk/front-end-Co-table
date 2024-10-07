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
  Future<String> createTable({required int number, required int roomId}) async {
    final response = await apiService.post('$_baseUrl/create', query: {
      'number': number,
      'room_id': roomId,
    });
    if (response.statusCode == 200) {
      return "Table created successfully";
    } else {
      throw Exception('Failed to create table');
    }
  }

  @override
  Future<TableModel> getTable() async {
    final response = await apiService.get('$_baseUrl/get');
    if (response.statusCode == 200) {
      return TableModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get table');
    }
  }

  @override
  Future<void> deleteTable({required int id}) async {
    final response = await apiService.delete('$_baseUrl/delete/$id');
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete table');
    }
  }
}
