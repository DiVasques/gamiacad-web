class CreateReward {
  String name;
  String description;
  int price;
  int availability;
  CreateReward({
    required this.name,
    required this.description,
    required this.price,
    required this.availability,
  });

  factory CreateReward.fromJson(Map<String, dynamic> json) => CreateReward(
        name: json['name'],
        description: json['description'],
        price: json['price'],
        availability: json['availability'],
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'price': price,
        'availability': availability,
      };
}
