sealed class ReservationEvent {}

class LoadReservationEvent extends ReservationEvent {}

class LoadReservationListEvent extends ReservationEvent {
  final int page;
  LoadReservationListEvent({this.page = 1});
}

class CreateReservationEvent extends ReservationEvent {
  final int userId;
  final int tableId;
  final int durationHours;
  CreateReservationEvent(
      {required this.userId,
      required this.tableId,
      required this.durationHours});
}

class GetReservationEvent extends ReservationEvent {
  final int reservationId;
  GetReservationEvent({required this.reservationId});
}

class DeleteReservationEvent extends ReservationEvent {
  final int reservationId;
  DeleteReservationEvent({required this.reservationId});
}
