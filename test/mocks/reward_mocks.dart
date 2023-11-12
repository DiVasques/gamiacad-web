import 'package:gami_acad_web/repository/models/action_with_date.dart';
import 'package:gami_acad_web/repository/models/create_reward.dart';
import 'package:gami_acad_web/repository/models/edit_reward.dart';
import 'package:gami_acad_web/repository/models/reward.dart';

class RewardMocks {
  static String rewardId = 'id';

  static Reward reward = Reward(
    id: rewardId,
    name: 'name',
    description: 'description',
    number: 1,
    price: 100,
    availability: 100,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    claimers: [ActionWithDate(id: '123', date: DateTime.now())],
    handed: [ActionWithDate(id: '456', date: DateTime.now())],
    active: true,
  );

  static CreateReward newReward = CreateReward(
    name: 'name',
    description: 'description',
    price: 100,
    availability: 100,
  );

  static EditReward editReward = EditReward(
    name: 'name',
    description: 'description',
  );
}
