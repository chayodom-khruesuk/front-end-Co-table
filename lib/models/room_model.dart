import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int id;
  final String name;
  final String faculty;
  final int userId;
  final bool status;

  const RoomModel({
    this.id = 0,
    required this.name,
    this.faculty = '',
    this.userId = 0,
    this.status = false,
  });

  factory RoomModel.empty() {
    return const RoomModel(
      id: 0,
      name: '',
      faculty: '',
      userId: 0,
      status: false,
    );
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'],
      faculty: json['faculty'],
      userId: json['user_id'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'faculty': faculty,
      'user_id': userId,
      'status': status,
    };
  }

  @override
  List<Object?> get props => [id, name, faculty, userId, status];
}

class RoomModelList extends Equatable {
  final List<RoomModel> rooms;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const RoomModelList({
    required this.rooms,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory RoomModelList.fromJson(Map<String, dynamic> json) {
    List<RoomModel> rooms = [];
    for (var room in json['rooms']) {
      rooms.add(RoomModel.fromJson(room));
    }
    return RoomModelList(
      rooms: rooms,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rooms': rooms.map((room) => room.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [rooms, page, pageCount, sizePerPage];
}
