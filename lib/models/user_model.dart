import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final int id;
  final String? username;
  final String? password;
  final String? name;
  final String? email;
  final String? roles;
  final String? faculty;
  final bool roomPermission;
  final String? registerDate;
  final String? updatedDate;
  final String? lastLoginDate;

  const UserModel({
    this.id = 0,
    this.username,
    this.password,
    this.name,
    this.email,
    this.roles,
    this.faculty,
    this.roomPermission = false,
    this.registerDate,
    this.updatedDate,
    this.lastLoginDate,
  });

  factory UserModel.empty() {
    return const UserModel(
      id: 0,
      username: '',
      password: '',
      name: '',
      email: '',
      roles: '',
      faculty: '',
      roomPermission: false,
      registerDate: '',
      updatedDate: '',
      lastLoginDate: '',
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      username: json['username'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      roles: json['roles'] as String?,
      faculty: json['faculty'] as String? ?? 'ไม่มีคณะ',
      roomPermission: json['room_permission'] ?? false,
      registerDate: json['register_date'] as String?,
      updatedDate: json['updated_date'] as String?,
      lastLoginDate: json['last_login_date'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'password': password,
      'name': name,
      'email': email,
      'roles': roles,
      'faculty': faculty,
      'room_permission': roomPermission,
      'register_date': registerDate,
      'updated_date': updatedDate,
    };
  }

  @override
  List<Object?> get props => [
        id,
        username,
        password,
        name,
        email,
        roles,
        faculty,
        roomPermission,
        registerDate,
        updatedDate,
        lastLoginDate,
      ];
}

class UserModelList extends Equatable {
  final List<UserModel> users;
  final int page;
  final int pageCount;
  final int sizePerPage;

  const UserModelList({
    required this.users,
    required this.page,
    required this.pageCount,
    required this.sizePerPage,
  });

  factory UserModelList.fromJson(Map<String, dynamic> json) {
    List<UserModel> users = [];
    for (var user in json['users']) {
      users.add(UserModel.fromJson(user));
    }
    return UserModelList(
      users: users,
      page: json['page'],
      pageCount: json['page_count'],
      sizePerPage: json['size_per_page'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'users': users.map((user) => user.toJson()).toList(),
      'page': page,
      'page_count': pageCount,
      'size_per_page': sizePerPage,
    };
  }

  @override
  List<Object?> get props => [users, page, pageCount, sizePerPage];
}
