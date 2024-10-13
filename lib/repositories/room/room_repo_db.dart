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
  Future<RoomModel> createRoom({
    String? faculty,
    required String name,
  }) async {
    final data = {'name': name, 'faculty': faculty ?? 'ไม่มีคณะ'};
    final response = await apiService.post('$_baseUrl/create_room', data: data);
    if (response.statusCode == 200) {
      return RoomModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create room');
    }
  }

  @override
  Future<List<RoomModel>> getAllRoom({int page = 1}) async {
    try {
      final response =
          await apiService.get('$_baseUrl/get_listRoom', query: {'page': page});
      if (response.statusCode == 200) {
        final roomList = RoomModelList.fromJson(response.data);
        rooms = roomList.rooms.where((room) => room.id != null).toList();
        return rooms;
      } else {
        throw Exception('Failed to get all room');
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<RoomModel> getRoom() async {
    final roomId = await Token.getRoomId();
    final response =
        await apiService.get('$_baseUrl/room_id', query: {'roomId': roomId});
    if (response.statusCode == 200) {
      return RoomModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get room');
    }
  }

  @override
  Future<String> updateRoom({
    required int roomId,
    required name,
    String? faculty,
  }) async {
    final roomId = await Token.getRoomId();
    final data = {'roomName': name};
    if (faculty != null) {
      data['faculty'] = faculty;
    }
    final response = await apiService
        .put('$_baseUrl/update_room', data: data, query: {'roomId': roomId});
    if (response.statusCode == 200) {
      return "Room updated successfully";
    } else {
      throw Exception('Failed to update room');
    }
  }

  @override
  Future<String> deleteRoom({required int roomId}) async {
    final roomId = await Token.getRoomId();
    final response = await apiService
        .delete('$_baseUrl/delete_room', query: {'roomId': roomId});
    if (response.statusCode == 200) {
      return "Room deleted successfully";
    } else {
      throw Exception('Failed to delete room');
    }
  }

  @override
  Future<bool> statusRoom({required int roomId}) async {
    final response = await apiService
        .put('$_baseUrl/status_room', query: {'room_id': roomId});
    print('respone status ${response.data}');
    if (response.statusCode == 200) {
      return response.data['status'];
    } else {
      throw Exception('Failed to toggle room status');
    }
  }
}
