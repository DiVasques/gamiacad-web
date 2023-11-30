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
    late RewardHandingController rewardHandingController;
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
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardHandingController.getClaimedRewards();

        // Assert
        expect(rewardHandingController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get claimed rewards',
          () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardHandingController.getClaimedRewards();

        // Assert
        expect(rewardHandingController.errorMessage, 'Error');
        expect(rewardHandingController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenThrow((_) async => UnauthorizedException);
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardHandingController.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.getClaimedRewards())
            .thenThrow((_) async => ServiceUnavailableException);
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardHandingController.getClaimedRewards();

        // Assert
        expect(rewardHandingController.state, ViewState.error);
      });
    });

    group('handReward', () {
      test('should return true when successful handing reward', () async {
        // Arrange
        when(
          rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          ),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardHandingController.handReward(
          rewardId: RewardMocks.rewardId,
          userId: UserMocks.userId,
        );

        // Assert
        expect(rewardHandingController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(
          rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          ),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardHandingController.handReward(
          rewardId: RewardMocks.rewardId,
          userId: UserMocks.userId,
        );

        // Assert
        expect(rewardHandingController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(
          rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          ),
        ).thenThrow((_) async => UnauthorizedException);
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardHandingController.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(
          rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          ),
        ).thenThrow((_) async => ServiceUnavailableException);
        rewardHandingController = RewardHandingController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardHandingController.handReward(
          rewardId: RewardMocks.rewardId,
          userId: UserMocks.userId,
        );

        // Assert
        expect(rewardHandingController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
