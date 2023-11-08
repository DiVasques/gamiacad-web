class User {
  String id;
  String name;
  String email;
  String registration;
  int balance;
  int totalPoints;
  DateTime createdAt;
  DateTime? updatedAt;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.registration,
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
