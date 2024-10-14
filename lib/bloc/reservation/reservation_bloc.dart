import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:co_table/bloc/reservation/reservation_event.dart';
import 'package:co_table/bloc/reservation/reservation_state.dart';
import 'package:co_table/repositories/reservation/reservation_repo.dart';
import 'package:co_table/models/models.dart';

class ReservationBloc extends Bloc<ReservationEvent, ReservationState> {
  final ReservationRepo reservationRepo;

  ReservationBloc({required this.reservationRepo})
      : super(LoadingReservationState()) {
    on<LoadReservationEvent>(_onLoadReservationEvent);
    on<LoadReservationListEvent>(_onLoadReservationListEvent);
    on<CreateReservationEvent>(_onCreateReservationEvent);
    on<UpdateReservationEvent>(_onUpdateReservationEvent);
    on<DeleteReservationEvent>(_onDeleteReservationEvent);
  }

  _onLoadReservationEvent(
      LoadReservationEvent event, Emitter<ReservationState> emit) async {
    try {
      final reservation = await reservationRepo.getReservation(
          reservationId: event.reservationId);
      emit(ReadyReservationState(
        reservation: reservation,
        reservationList: [],
        responseText: 'Reservation loaded successfully',
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: [],
        responseText: 'Failed to load reservation',
      ));
    }
  }

  _onLoadReservationListEvent(
      LoadReservationListEvent event, Emitter<ReservationState> emit) async {
    try {
      final reservations = await reservationRepo.getAllReservation();
      emit(ReadyReservationState(
        reservation: state.reservation,
        reservationList: reservations,
        currentPage: event.page,
        responseText: 'Reservations loaded successfully',
        isDataLoaded: true,
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: state.reservation,
        reservationList: [],
        currentPage: 0,
        responseText: 'Failed to load reservations',
        isDataLoaded: true,
      ));
    }
  }

  _onCreateReservationEvent(
      CreateReservationEvent event, Emitter<ReservationState> emit) async {
    try {
      final userReservations =
          state.reservationList.where((r) => r.userId == event.userId);
      if (userReservations.isNotEmpty) {
        emit(ReadyReservationState(
          reservation: state.reservation,
          reservationList: state.reservationList,
          responseText: 'You can only reserve one table at a time.',
        ));
        return;
      }

      final reservation = await reservationRepo.createReservation(
        userId: event.userId,
        tableId: event.tableId,
        durationHours: event.durationHours,
      );
      final reservations = await reservationRepo.getAllReservation();
      emit(ReadyReservationState(
        reservation: reservation,
        reservationList: reservations,
        responseText: 'Reservation created successfully',
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: [],
        responseText: 'Failed to create reservation',
      ));
    }
  }

  _onUpdateReservationEvent(
      UpdateReservationEvent event, Emitter<ReservationState> emit) async {
    try {
      final updatedReservation = await reservationRepo.updateReservation(
        reservationId: event.reservationId,
        durationHours: event.durationHours,
        userId: event.userId,
        tableId: event.tableId,
      );
      final reservations = await reservationRepo.getAllReservation();
      emit(ReadyReservationState(
        reservation: updatedReservation,
        reservationList: reservations,
        responseText: 'Reservation updated successfully',
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: [],
        responseText: 'Failed to update reservation',
      ));
    }
  }

  _onDeleteReservationEvent(
      DeleteReservationEvent event, Emitter<ReservationState> emit) async {
    try {
      await reservationRepo.deleteReservation(
          reservationId: event.reservationId);
      final reservations = await reservationRepo.getAllReservation();
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: reservations,
        responseText: 'Reservation deleted successfully',
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: state.reservation,
        reservationList: state.reservationList,
        responseText: 'Failed to delete reservation',
      ));
    }
  }
}
