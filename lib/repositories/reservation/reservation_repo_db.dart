import 'package:co_table/models/models.dart';
import 'package:co_table/repositories/reservation/reservation_repo.dart';
import 'package:co_table/services/services.dart';

class ReservationRepoDb extends ReservationRepo {
  late List<ReservationModel> reservations = [];
  late ReservationModel reservation;
  late ReservationModelList reservationList;

  final ApiService apiService = ApiService();
  final String _baseUrl = '/reservations';

  @override
  Future<ReservationModel> createReservation({
    required int durationHours,
    required int tableId,
    required int userId,
  }) async {
    final data = {
      'duration_hours': durationHours,
      'table_id': tableId,
      'user_id': userId,
    };
    final response =
        await apiService.post('$_baseUrl/create_reservation', data: data);
    if (response.statusCode == 200) {
      return ReservationModel.fromJson(response.data);
    } else {
      throw Exception('Failed to create reservation');
    }
  }

  @override
  Future<ReservationModel> getReservation() async {
    final reservationId = await Token.getReservataionId();
    final response = await apiService.get('$_baseUrl/get_id_reservation',
        query: {'reservation_id': reservationId});
    if (response.statusCode == 200) {
      return ReservationModel.fromJson(response.data);
    } else {
      throw Exception('Failed to get reservation');
    }
  }

  @override
  Future<List<ReservationModel>> getAllReservation({int page = 1}) async {
    try {
      final response = await apiService
          .get('$_baseUrl/get_list_reservation', query: {'page': page});
      if (response.statusCode == 200) {
        final reservationList = ReservationModelList.fromJson(response.data);
        reservations =
            reservationList.reservations.where((room) => room.id != 0).toList();
        return reservations;
      } else {
        throw Exception('Failed to get all room');
      }
    } catch (e) {
      return [];
    }
  }

  @override
  Future<ReservationModel> updateReservation({
    required int reservationId,
    required int userId,
    required int tableId,
    required int durationHours,
  }) async {
    final data = {
      'user_id': userId,
      'table_id': tableId,
      'duration_hours': durationHours,
    };
    final reservationId = await Token.getReservataionId();
    final response = await apiService.put(
      '$_baseUrl/update_reservation/',
      data: data,
      query: {'reservation_id': reservationId},
    );
    if (response.statusCode == 200) {
      return ReservationModel.fromJson(response.data);
    } else {
      throw Exception('Failed to update reservation');
    }
  }

  @override
  Future<String> deleteReservation({required int reservationId}) async {
    final response =
        await apiService.delete('$_baseUrl/delete_reservation/$reservationId');
    if (response.statusCode == 200) {
      return 'Reservation deleted successfully';
    } else {
      throw Exception('Failed to delete reservation');
    }
  }
}
