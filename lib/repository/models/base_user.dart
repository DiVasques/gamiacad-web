class BaseUser {
  String id;
  String name;
  String registration;

  BaseUser({
    required this.id,
    required this.name,
    required this.registration,
  });

  factory BaseUser.fromJson(Map<String, dynamic> json) => BaseUser(
        id: json['id'],
        name: json['name'],
        registration: json['registration'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'registration': registration,
      };
}
