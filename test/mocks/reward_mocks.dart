import 'package:gami_acad_web/repository/models/action_with_date.dart';
import 'package:gami_acad_web/repository/models/base_user.dart';
import 'package:gami_acad_web/repository/models/claimed_reward.dart';
import 'package:gami_acad_web/repository/models/create_reward.dart';
import 'package:gami_acad_web/repository/models/edit_reward.dart';
import 'package:gami_acad_web/repository/models/reward.dart';

import 'user_mocks.dart';

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
    claimers: [
      ActionWithDate(
        id: UserMocks.userId,
        date: DateTime.now(),
        createdBy: UserMocks.userId,
      ),
    ],
    claimersInfo: [
      UserMocks.user,
    ],
    handed: [
      ActionWithDate(
        id: UserMocks.user2Id,
        date: DateTime.now(),
        createdBy: '789',
      ),
    ],
    handedInfo: [
      UserMocks.user2,
    ],
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

  static ClaimedReward claimedReward = ClaimedReward(
    id: rewardId,
    name: 'name',
    number: 1,
    price: 100,
    claimDate: DateTime.now(),
    claimer: BaseUser(
      id: '123',
      name: 'Claimer Name',
      registration: '12345678909',
    ),
  );
}
