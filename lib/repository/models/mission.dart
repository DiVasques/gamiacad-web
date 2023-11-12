import 'package:gami_acad_web/repository/models/action_with_date.dart';
import 'package:gami_acad_web/repository/models/user.dart';

class Mission {
  String id;
  String name;
  String description;
  int number;
  int points;
  DateTime expirationDate;
  DateTime createdAt;
  DateTime? updatedAt;
  String createdBy;
  User createdByInfo;
  List<ActionWithDate> participants;
  List<User> participantsInfo;
  List<ActionWithDate> completers;
  List<User> completersInfo;
  bool active;
  Mission({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
    required this.points,
    required this.expirationDate,
    required this.createdAt,
    required this.updatedAt,
    required this.createdBy,
    required this.createdByInfo,
    required this.participants,
    required this.participantsInfo,
    required this.completers,
    required this.completersInfo,
    required this.active,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        number: json['number'],
        points: json['points'],
        expirationDate: DateTime.parse(json['expirationDate']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.tryParse(json['updatedAt'] ?? ''),
        createdBy: json['createdBy'],
        createdByInfo: User.fromJson(json['createdByInfo']),
        participants: (json['participants'] as List<dynamic>)
            .map((p) => ActionWithDate.fromJson(p))
            .toList(),
        participantsInfo: (json['participantsInfo'] as List<dynamic>)
            .map((p) => User.fromJson(p))
            .toList(),
        completers: (json['completers'] as List<dynamic>)
            .map((c) => ActionWithDate.fromJson(c))
            .toList(),
        completersInfo: (json['completersInfo'] as List<dynamic>)
            .map((c) => User.fromJson(c))
            .toList(),
        active: json['active'],
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'number': number,
        'points': points,
        'expirationDate': expirationDate.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'createdBy': createdBy,
        'createdByInfo': createdByInfo.toJson(),
        'participants': participants.map((e) => e.toJson()).toList(),
        'participantsInfo': participantsInfo.map((e) => e.toJson()).toList(),
        'completers': completers.map((e) => e.toJson()).toList(),
        'completersInfo': completersInfo..map((e) => e.toJson()).toList(),
        'active': active,
      };
}
