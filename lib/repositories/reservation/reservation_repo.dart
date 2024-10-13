import 'package:co_table/models/models.dart';

abstract class ReservationRepo {
  Future<String> createReservation({
    required String reservedAt,
    required String startTime,
    required String endTime,
    required int durationHours,
  });

  Future<ReservationModel> getReservations();

  Future<String> updateReservation({
    required int id,
    required int durationHours,
  });

  Future<void> deleteReservation({required int id});
}
