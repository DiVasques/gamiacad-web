class Mission {
  String id;
  String name;
  String description;
  int number;
  int points;
  DateTime expirationDate;
  DateTime createdAt;
  DateTime updatedAt;
  String createdBy;
  List<String> participants;
  List<String> completers;
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
    required this.participants,
    required this.completers,
  });

  factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        number: json['number'],
        points: json['points'],
        expirationDate: DateTime.parse(json['expirationDate']),
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
        createdBy: json['createdBy'],
        participants: (json['participants'] as List<dynamic>)
            .map((p) => p as String)
            .toList(),
        completers: (json['completers'] as List<dynamic>)
            .map((c) => c as String)
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'number': number,
        'points': points,
        'expirationDate': expirationDate.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
        'createdBy': createdBy,
        'participants': participants,
        'completers': completers,
      };
}
