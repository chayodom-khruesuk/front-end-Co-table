import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int? id;
  final String name;
  final String faculty;
  final int userId;
  final bool status;

  const RoomModel({
    this.id,
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
      id: json['id'] as int?,
      name: json['name'] ?? '',
      faculty: json['faculty'] ?? '',
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? false,
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
    List<RoomModel> rooms = (json['rooms'] as List<dynamic>?)
            ?.map((room) => RoomModel.fromJson(room))
            .where((room) => room.id != null)
            .toList() ??
        [];
    return RoomModelList(
      rooms: rooms,
      page: json['page'] ?? 1,
      pageCount: json['page_count'] ?? 1,
      sizePerPage: json['size_per_page'] ?? 10,
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
