import 'package:co_table/models/models.dart';

abstract class ReservationRepo {
  Future<ReservationModel> createReservation({
    required int userId,
    required int tableId,
    required int durationHours,
  });

  Future<ReservationModel> getReservation({required int reservationId});

  Future<List<ReservationModel>> getAllReservation({int page = 1});

  Future<ReservationModel> updateReservation({
    required int reservationId,
    required int userId,
    required int tableId,
    required int durationHours,
  });

  Future<String> deleteReservation({required int reservationId});
}
