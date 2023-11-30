import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/reward_handing_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/reward_mocks.dart';
import '../../mocks/user_mocks.dart';
import 'reward_controller_test.mocks.dart';

@GenerateMocks([RewardRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardHandingController', () {
    late RewardHandingController rewardController;
    late MockRewardRepository rewardRepository;

    setUp(() {
      rewardRepository = MockRewardRepository();
      when(rewardRepository.claimedRewards)
          .thenReturn([RewardMocks.claimedReward]);
    });

    group('getClaimedRewards', () {
      test('should return claimed rewards', () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getClaimedRewards();

        // Assert
        expect(rewardController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get claimed rewards',
          () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getClaimedRewards();

        // Assert
        expect(rewardController.errorMessage, 'Error');
        expect(rewardController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getClaimedRewards();

        // Assert
        expect(rewardController.state, ViewState.error);
      });
    });
  });
}
