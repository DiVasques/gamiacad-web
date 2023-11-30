import 'package:gami_acad_web/repository/models/base_user.dart';

class User extends BaseUser {
  String email;
  int balance;
  int totalPoints;
  DateTime createdAt;
  DateTime? updatedAt;

  User({
    required super.id,
    required super.name,
    required this.email,
    required super.registration,
    required this.balance,
    required this.totalPoints,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'],
        name: json['name'],
        email: json['email'],
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
        'registration': registration,
        'balance': balance,
        'totalPoints': totalPoints,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
