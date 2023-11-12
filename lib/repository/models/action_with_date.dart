class ActionWithDate {
  String id;
  DateTime date;
  ActionWithDate({
    required this.id,
    required this.date,
  });

  factory ActionWithDate.fromJson(Map<String, dynamic> json) => ActionWithDate(
        id: json['id'],
        date: json['date'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date,
      };
}