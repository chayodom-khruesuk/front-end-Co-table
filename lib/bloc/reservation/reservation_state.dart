import '../../models/models.dart';

sealed class ReservationState {
  final ReservationModel reservation;
  final List<ReservationModel> reservationList;
  final String responseText;
  ReservationState({
    required this.reservation,
    required this.reservationList,
    this.responseText = '',
  });
}

const List<ReservationModel> emptyReservationList = [];

class LoadingReservationState extends ReservationState {
  LoadingReservationState({super.responseText})
      : super(
            reservation: ReservationModel.empty(),
            reservationList: emptyReservationList);
}

class ReadyReservationState extends ReservationState {
  final int currentPage;
  final bool isDataLoaded;

  ReadyReservationState({
    required super.reservation,
    required super.reservationList,
    this.currentPage = 0,
    this.isDataLoaded = false,
    super.responseText = '',
  });
}
