import 'package:equatable/equatable.dart';

class TableModel extends Equatable {
  final int id;
  final int number;
  final int roomId;
  final bool isAvailable;

  const TableModel({
    this.id = 0,
    required this.number,
    required this.roomId,
    this.isAvailable = false,
  });

  factory TableModel.empty() {
    return const TableModel(
      id: 0,
      number: 0,
      roomId: 0,
      isAvailable: false,
    );
  }

  factory TableModel.fromJson(Map<String, dynamic> json) {
    return TableModel(
      id: json['id'],
      number: json['number'],
      roomId: json['room_id'],
      isAvailable: json['is_available'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'number': number,
      'room_id': roomId,
      'is_available': isAvailable,
    };
  }

  @override
  List<Object?> get props => [id, number, roomId];
}

class TableModelList extends Equatable {
  final List<TableModel> tables;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const TableModelList({
    required this.tables,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory TableModelList.fromJson(Map<String, dynamic> json) {
    List<TableModel> tables = [];
    for (var table in json['tables']) {
      tables.add(TableModel.fromJson(table));
    }
    return TableModelList(
      tables: tables,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tables': tables.map((table) => table.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [tables, page, pageCount, sizePerPage];
}
