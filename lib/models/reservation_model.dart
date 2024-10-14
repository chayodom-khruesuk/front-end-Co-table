import 'package:equatable/equatable.dart';

class ReservationModel extends Equatable {
  final int id;
  final String reservedAt;
  final String startTime;
  final String endTime;
  final int durationHours;
  final int userId;
  final int tableId;

  const ReservationModel({
    this.id = 0,
    required this.reservedAt,
    required this.startTime,
    required this.endTime,
    required this.durationHours,
    this.userId = 0,
    this.tableId = 0,
  });

  factory ReservationModel.empty() {
    return const ReservationModel(
      id: 0,
      reservedAt: '',
      startTime: '',
      endTime: '',
      durationHours: 0,
      userId: 0,
      tableId: 0,
    );
  }

  factory ReservationModel.fromJson(Map<String, dynamic> json) {
    return ReservationModel(
      id: json['id'],
      reservedAt: json['reserved_at'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      durationHours: json['duration_hours'],
      userId: json['user_id'],
      tableId: json['table_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'reserved_at': reservedAt,
      'start_time': startTime,
      'end_time': endTime,
      'duration_hours': durationHours,
      'user_id': userId,
      'table_id': tableId,
    };
  }

  @override
  List<Object?> get props =>
      [id, reservedAt, startTime, endTime, durationHours, userId, tableId];

  get roomId => null;
}

class ReservationModelList extends Equatable {
  final List<ReservationModel> reservations;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const ReservationModelList({
    required this.reservations,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory ReservationModelList.fromJson(Map<String, dynamic> json) {
    List<ReservationModel> reservations = [];
    for (var reservation in json['reservations']) {
      reservations.add(ReservationModel.fromJson(reservation));
    }
    return ReservationModelList(
      reservations: reservations,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'reservations':
          reservations.map((reservation) => reservation.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [reservations, page, pageCount, sizePerPage];
}
