import 'package:gami_acad_web/repository/models/action_with_date.dart';
import 'package:gami_acad_web/repository/models/user.dart';

class Reward {
  String id;
  String name;
  String description;
  int number;
  int price;
  int availability;
  DateTime createdAt;
  DateTime? updatedAt;
  List<ActionWithDate> claimers;
  List<User> claimersInfo;
  List<ActionWithDate> handed;
  List<User> handedInfo;
  bool active;
  Reward({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
    required this.price,
    required this.availability,
    required this.createdAt,
    required this.updatedAt,
    required this.claimers,
    required this.claimersInfo,
    required this.handed,
    required this.handedInfo,
    required this.active,
  });

  factory Reward.fromJson(Map<String, dynamic> json) => Reward(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        number: json['number'],
        price: json['price'],
        availability: json['availability'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
        claimers: (json['claimers'] as List<dynamic>)
            .map((p) => ActionWithDate.fromJson(p))
            .toList(),
        claimersInfo: (json['claimersInfo'] as List<dynamic>)
            .map((p) => User.fromJson(p))
            .toList(),
        handed: (json['handed'] as List<dynamic>)
            .map((c) => ActionWithDate.fromJson(c))
            .toList(),
        handedInfo: (json['handedInfo'] as List<dynamic>)
            .map((p) => User.fromJson(p))
            .toList(),
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'number': number,
        'price': price,
        'availability': availability,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'claimers': claimers.map((e) => e.toJson()).toList(),
        'claimersInfo': claimersInfo.map((e) => e.toJson()).toList(),
        'handed': handed.map((e) => e.toJson()).toList(),
        'handedInfo': handedInfo.map((e) => e.toJson()).toList(),
        'active': active,
      };
}
