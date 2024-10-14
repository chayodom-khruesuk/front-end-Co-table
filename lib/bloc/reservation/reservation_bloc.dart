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
      final reservation = await reservationRepo.getReservation();
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
      final reservation = await reservationRepo.getReservation();
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

  _onCreateReservationEvent(
      CreateReservationEvent event, Emitter<ReservationState> emit) async {
    emit(LoadingReservationState());
    try {
      final reservation = await reservationRepo.createReservation(
        userId: event.userId,
        tableId: event.tableId,
        durationHours: event.durationHours,
      );
      emit(ReadyReservationState(
        reservation: reservation,
        reservationList: [],
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
      emit(ReadyReservationState(
        reservation: updatedReservation,
        reservationList: [],
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
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: [],
        responseText: 'Reservation deleted successfully',
      ));
    } catch (e) {
      emit(ReadyReservationState(
        reservation: ReservationModel.empty(),
        reservationList: [],
        responseText: 'Failed to delete reservation',
      ));
    }
  }
}
