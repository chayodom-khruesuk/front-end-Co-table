import 'package:co_table/models/models.dart';

abstract class RoomRepo {
  Future<String> createRoom({
    required String name,
  });
  Future<RoomModel> getRoom();
  Future<String> updateRoom({
    required int id,
  });
  Future<void> deleteRoom({
    required int id,
  });
}
