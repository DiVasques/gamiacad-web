class ActionWithDate {
  String id;
  DateTime date;
  String createdBy;
  ActionWithDate({
    required this.id,
    required this.date,
    required this.createdBy,
  });

  factory ActionWithDate.fromJson(Map<String, dynamic> json) => ActionWithDate(
        id: json['id'],
        date: DateTime.parse(json['date']),
        createdBy: json['createdBy'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'createdBy': createdBy,
      };
}
