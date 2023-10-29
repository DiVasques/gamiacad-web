class EditMission {
  String name;
  String description;
  DateTime expirationDate;
  EditMission({
    required this.name,
    required this.description,
    required this.expirationDate,
  });

  factory EditMission.fromJson(Map<String, dynamic> json) => EditMission(
        name: json['name'],
        description: json['description'],
        expirationDate: DateTime.parse(json['expirationDate']),
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'expirationDate': expirationDate.toIso8601String(),
      };
}
