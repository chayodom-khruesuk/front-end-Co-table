import 'package:co_table/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/room/room_repo.dart';
import '../bloc.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final RoomRepo roomRepo;

  RoomBloc({required this.roomRepo}) : super(LoadingRoomState()) {
    on<LoadRoomEvent>(_onLoadRoomEvent);
    on<LoadRoomListEvent>(_onLoadRoomListEvent);
    on<CreateRoomEvent>(_onCreateRoomEvent);
    on<UpdateRoomEvent>(_onUpdateRoomEvent);
    on<DeleteRoomEvent>(_onDeleteRoomEvent);
  }

  _onLoadRoomEvent(LoadRoomEvent event, Emitter<RoomState> emit) async {
    if (state is LoadingRoomState) {
      final room = await roomRepo.getRoom();
      debugPrint("room: ${room.toString()}");
      emit(ReadyRoomState(room: room, roomList: emptyRoomList));
    }
  }

  _onLoadRoomListEvent(LoadRoomListEvent event, Emitter<RoomState> emit) async {
    if (state is ReadyRoomState) {
      final currentState = state as ReadyRoomState;
      if (!currentState.isDataLoaded) {
        emit(LoadingRoomState());
        try {
          final rooms = await roomRepo.getAllRoom(page: 1);
          emit(ReadyRoomState(
            room: currentState.room,
            roomList: rooms,
            currentPage: 1,
            isDataLoaded: true,
          ));
        } catch (e) {
          emit(ReadyRoomState(
            room: currentState.room,
            roomList: [],
            currentPage: 0,
            isDataLoaded: true,
          ));
        }
      }
    } else {
      emit(LoadingRoomState());
      try {
        final rooms = await roomRepo.getAllRoom(page: 1);
        emit(ReadyRoomState(
            room: RoomModel.empty(), roomList: rooms, currentPage: 1));
      } catch (e) {
        emit(ReadyRoomState(
            room: RoomModel.empty(), roomList: [], currentPage: 0));
      }
    }
  }

  _onCreateRoomEvent(CreateRoomEvent event, Emitter<RoomState> emit) async {
    final response = await roomRepo.createRoom(
      name: event.name,
      faculty: event.faculty ?? 'ไม่มีคณะ',
    );
    emit(LoadingRoomState(responseText: response));
    if (response.contains("สร้างห้องสำเร็จ")) {
      add(LoadRoomEvent());
    }
  }

  _onUpdateRoomEvent(UpdateRoomEvent event, Emitter<RoomState> emit) async {
    if (state is ReadyRoomState) {
      final currentRoom = (state as ReadyRoomState).room;
      final response = await roomRepo.updateRoom(
        roomId: currentRoom.id,
        name: event.name,
        faculty: event.faculty ?? 'ไม่มีคณะ',
      );
      emit(LoadingRoomState(responseText: response));
      add(LoadRoomEvent());
    }
  }

  _onDeleteRoomEvent(DeleteRoomEvent event, Emitter<RoomState> emit) async {
    if (state is ReadyRoomState) {
      final currentRoom = (state as ReadyRoomState).room;
      final response = await roomRepo.deleteRoom(roomId: currentRoom.id);
      emit(LoadingRoomState(responseText: response));
      add(LoadRoomEvent());
    }
  }
}
