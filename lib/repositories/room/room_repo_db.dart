import 'package:co_table/models/room_model.dart';
import 'package:co_table/repositories/room/room_repo.dart';
import 'package:co_table/services/services.dart';

class RoomRepoDb extends RoomRepo {
  late List<RoomModel> rooms = [];
  late RoomModel room;
  late RoomModelList roomList;

  final ApiService apiService = ApiService();
  final String _baseUrl = '/rooms';

  @override
  Future<String> createRoom({
    required String name,
  }) async {
    final response =
        await apiService.post('$_baseUrl/create', query: {'name': name});
    if (response.statusCode == 200) {
      return "Room created successfully";
    } else {
      throw Exception('Failed to create room');
    }
  }

  @override
  Future<RoomModel> getRoom() async {
    final response = await apiService.get('$_baseUrl/get');
    if (response.statusCode == 200) {
      return RoomModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get room');
    }
  }

  @override
  Future<String> updateRoom({required int id}) async {
    final response = await apiService.put('$_baseUrl/put/$id');
    if (response.statusCode == 200) {
      return "Room updated successfully";
    } else {
      throw Exception('Failed to update room');
    }
  }

  @override
  Future<void> deleteRoom({required int id}) async {
    final response = await apiService.delete('$_baseUrl/delete/$id');
    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to delete room');
    }
  }
}
