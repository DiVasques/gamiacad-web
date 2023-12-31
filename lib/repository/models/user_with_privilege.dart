import 'package:gami_acad_web/repository/models/user.dart';

class UserWithPrivilege extends User {
  bool admin;
  bool active;

  UserWithPrivilege({
    required super.id,
    required super.name,
    required super.email,
    required super.registration,
    required super.balance,
    required super.totalPoints,
    required super.createdAt,
    required super.updatedAt,
    required this.admin,
    required this.active,
  });

  factory UserWithPrivilege.fromJson(Map<String, dynamic> json) =>
      UserWithPrivilege(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
        admin: json['admin'],
        active: json['active'],
        registration: json['registration'],
        balance: json['balance'],
        totalPoints: json['totalPoints'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
      );

  @override
  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'admin': admin,
        'active': active,
        'registration': registration,
        'balance': balance,
        'totalPoints': totalPoints,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
