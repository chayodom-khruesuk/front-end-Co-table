import 'package:co_table/models/models.dart';
import 'package:equatable/equatable.dart';

class RoomModel extends Equatable {
  final int id;
  final String name;
  final String faculty;
  final List<TableModel> tables;
  final int userId;
  final bool status;

  const RoomModel({
    required this.id,
    required this.name,
    this.faculty = '',
    this.tables = const [],
    this.userId = 0,
    this.status = true,
  });

  factory RoomModel.empty() {
    return const RoomModel(
      id: 0,
      name: '',
      faculty: '',
      tables: [],
      userId: 0,
      status: true,
    );
  }

  factory RoomModel.fromJson(Map<String, dynamic> json) {
    return RoomModel(
      id: json['id'],
      name: json['name'] ?? '',
      faculty: json['faculty'] ?? '',
      tables: (json['tables'] ?? []),
      userId: json['user_id'] ?? 0,
      status: json['status'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'faculty': faculty,
      'tables': tables,
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
            .where((room) => room.id != 0)
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
