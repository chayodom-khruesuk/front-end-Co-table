import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/models.dart';
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
    on<StatusRoomEvent>(_onStatusRoomEvent);
    on<SearchRoomsEvent>(_onSearchRoomsEvent);
  }

  _onSearchRoomsEvent(SearchRoomsEvent event, Emitter<RoomState> emit) {
    if (state is ReadyRoomState) {
      final currentState = state as ReadyRoomState;
      final filteredRooms = currentState.roomList.where((room) {
        return room.name
                .toLowerCase()
                .contains(event.searchTerm.toLowerCase()) ||
            room.faculty.toLowerCase().contains(event.searchTerm.toLowerCase());
      }).toList();
      emit(ReadyRoomState(
        room: currentState.room,
        roomList: currentState.roomList,
        filteredRoomList: filteredRooms,
        currentPage: currentState.currentPage,
        isDataLoaded: true,
      ));
    }
  }

  _onLoadRoomEvent(LoadRoomEvent event, Emitter<RoomState> emit) async {
    if (state is LoadingRoomState) {
      final room = await roomRepo.getRoom();
      debugPrint("room: ${room.toString()}");
      emit(ReadyRoomState(room: room, roomList: emptyRoomList));
    }
  }

  _onLoadRoomListEvent(LoadRoomListEvent event, Emitter<RoomState> emit) async {
    emit(LoadingRoomState());
    try {
      final rooms = await roomRepo.getAllRoom(page: event.page);
      emit(ReadyRoomState(
        room: state.room,
        roomList: rooms,
        currentPage: event.page,
        isDataLoaded: true,
      ));
    } catch (e) {
      emit(ReadyRoomState(
        room: state.room,
        roomList: [],
        currentPage: 0,
        isDataLoaded: true,
      ));
    }
  }

  _onCreateRoomEvent(CreateRoomEvent event, Emitter<RoomState> emit) async {
    if (state is ReadyRoomState) {
      final currentState = state as ReadyRoomState;
      emit(LoadingRoomState());
      try {
        final newRoom = await roomRepo.createRoom(
          name: event.name,
          faculty: event.faculty,
          userId: event.userId,
        );
        final updatedRooms = [newRoom, ...currentState.roomList];
        emit(ReadyRoomState(
          room: newRoom,
          roomList: updatedRooms,
          currentPage: currentState.currentPage,
          isDataLoaded: true,
          responseText: "ห้องถูกสร้างเรียบร้อยแล้ว",
        ));
      } catch (e) {
        emit(ReadyRoomState(
          room: currentState.room,
          roomList: currentState.roomList,
          currentPage: currentState.currentPage,
          isDataLoaded: true,
          responseText: "เกิดข้อผิดพลาดในการสร้างห้อง",
        ));
      }
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
      final response = await roomRepo.deleteRoom(roomId: event.roomId);
      // print('response delete: $response ');
      emit(LoadingRoomState(responseText: response));
      add(LoadRoomListEvent());
    }
  }

  _onStatusRoomEvent(StatusRoomEvent event, Emitter<RoomState> emit) async {
    if (state is ReadyRoomState) {
      final currentState = state as ReadyRoomState;
      try {
        final newStatus = await roomRepo.statusRoom(roomId: event.roomId);
        final updatedRoomList = currentState.roomList.map((room) {
          if (room.id == event.roomId) {
            return RoomModel(
              id: room.id,
              name: room.name,
              faculty: room.faculty,
              userId: room.userId,
              status: newStatus,
            );
          }
          return room;
        }).toList();
        emit(ReadyRoomState(
          room: currentState.room,
          roomList: updatedRoomList,
          currentPage: currentState.currentPage,
          isDataLoaded: true,
          responseText: "Room status updated successfully",
        ));
      } catch (e) {
        emit(ReadyRoomState(
          room: currentState.room,
          roomList: currentState.roomList,
          currentPage: currentState.currentPage,
          isDataLoaded: true,
          responseText: "Failed to update room status",
        ));
      }
    }
  }
}
