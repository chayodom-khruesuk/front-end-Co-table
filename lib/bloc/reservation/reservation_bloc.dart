import 'package:co_table/bloc/reservation/reservation_event.dart';
import 'package:co_table/bloc/reservation/reservation_state.dart';
import 'package:co_table/repositories/reservation/reservation_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepo reservationRepo;

  ReservationBloc({required this.reservationRepo})
      : super(LoadingReservationState()) {
    on<LoadReservationEvent>(_onLoadReservationEvent);
    on<LoadReservationListEvent>(_onLoadReservationListEvent);
    on<CreateReservationEvent>(_onCreateReservationEvent);
    on<DeleteReservationEvent>(_onDeleteReservationEvent);
  }

  Future<void> _onLoadReservationEvent(
      LoadReservationEvent event, Emitter<ReservationState> emit) async {
    if (state is LoadingReservationState) {
      final currentReservation = (state as ReadyReservationState).reservation;
      final reservation = await reservationRepo.getReservation(
          reservationId: currentReservation.id);
      emit(
          ReadyReservationState(reservation: reservation, reservationList: []));
    }
  }

  Future<void> _onLoadReservationListEvent(
      LoadReservationListEvent event, Emitter<ReservationState> emit) async {
    try {
      final reservations =
          await reservationRepo.getAllReservation(page: event.page);
      emit(ReadyReservationState(
        reservation: state.reservation,
        reservationList: reservations,
        currentPage: event.page,
        isDataLoaded: true,
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: state.reservation,
        reservationList: [],
        currentPage: 0,
        isDataLoaded: true,
      ));
    }
  }

  Future<void> _onCreateReservationEvent(
      CreateReservationEvent event, Emitter<ReservationState> emit) async {
    if (state is ReadyReservationState) {
      final response = await reservationRepo.createReservation(
          userId: event.userId,
          tableId: event.tableId,
          durationHours: event.durationHours);
      add(LoadReservationEvent());
    }
  }

  Future<void> _onDeleteReservationEvent(
      DeleteReservationEvent event, Emitter<ReservationState> emit) async {
    if (state is ReadyReservationState) {
      final currentReservation = (state as ReadyReservationState).reservation;
      final response = await reservationRepo.deleteReservation(
          reservationId: currentReservation.id);
      emit(LoadingReservationState(responseText: response));
      add(LoadReservationEvent());
    }
  }
}
