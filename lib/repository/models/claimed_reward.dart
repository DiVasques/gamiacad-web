import 'package:gami_acad_web/repository/models/base_user.dart';

class ClaimedReward {
  String id;
  String name;
  int number;
  int price;
  DateTime claimDate;
  BaseUser claimer;
  ClaimedReward({
    required this.id,
    required this.name,
    required this.number,
    required this.price,
    required this.claimer,
    required this.claimDate,
  });

  factory ClaimedReward.fromJson(Map<String, dynamic> json) => ClaimedReward(
        id: json['_id'],
        name: json['name'],
        number: json['number'],
        price: json['price'],
        claimDate: DateTime.parse(json['claimDate']),
        claimer: BaseUser.fromJson(json['claimer']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'number': number,
        'price': price,
        'claimDate': claimDate.toIso8601String(),
        'claimer': claimer.toJson(),
      };
}
