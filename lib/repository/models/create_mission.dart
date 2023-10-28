class CreateMission {
  String name;
  String description;
  int points;
  DateTime expirationDate;
  String createdBy;
  CreateMission({
    required this.name,
    required this.description,
    required this.points,
    required this.expirationDate,
    required this.createdBy,
  });

  factory CreateMission.fromJson(Map<String, dynamic> json) => CreateMission(
        name: json['name'],
        description: json['description'],
        points: json['points'],
        expirationDate: DateTime.parse(json['expirationDate']),
        createdBy: json['createdBy'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'points': points,
        'expirationDate': expirationDate.toIso8601String(),
        'createdBy': createdBy,
      };
}
