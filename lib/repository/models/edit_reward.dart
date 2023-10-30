class EditReward {
  String name;
  String description;
  EditReward({
    required this.name,
    required this.description,
  });

  factory EditReward.fromJson(Map<String, dynamic> json) => EditReward(
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
      };
}
