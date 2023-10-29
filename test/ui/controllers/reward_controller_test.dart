import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/create_reward.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/reward.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reward_controller_test.mocks.dart';

@GenerateMocks([RewardRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardController', () {
    late RewardController rewardController;
    late MockRewardRepository rewardRepository;

    String userId = 'userId';

    String rewardId = 'id';

    Reward reward = Reward(
      id: rewardId,
      name: 'name',
      description: 'description',
      number: 1,
      price: 100,
      availability: 100,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
      claimers: ["123"],
      handed: ["456"],
      active: true,
    );

    CreateReward newReward = CreateReward(
      name: 'name',
      description: 'description',
      price: 100,
      availability: 100,
    );

    setUp(() {
      rewardRepository = MockRewardRepository();
      when(rewardRepository.rewards).thenReturn([reward]);
    });

    group('getRewards', () {
      test('should return rewards', () async {
        // Arrange
        when(rewardRepository.getRewards())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getRewards();

        // Assert
        expect(rewardController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get rewards', () async {
        // Arrange
        when(rewardRepository.getRewards())
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getRewards();

        // Assert
        expect(rewardController.errorMessage, 'Error');
        expect(rewardController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.getRewards())
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.getRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.getRewards())
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        await rewardController.getRewards();

        // Assert
        expect(rewardController.state, ViewState.error);
      });
    });

    group('createReward', () {
      test('should return true when successful creating reward', () async {
        // Arrange
        when(rewardRepository.createReward(newReward: anyNamed('newReward')))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: newReward.name,
          description: newReward.description,
          price: newReward.price,
          availability: newReward.availability,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result on failed create reward',
          () async {
        // Arrange
        when(rewardRepository.createReward(newReward: anyNamed('newReward')))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: newReward.name,
          description: newReward.description,
          price: newReward.price,
          availability: newReward.availability,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.createReward(newReward: anyNamed('newReward')))
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.createReward(
            name: newReward.name,
            description: newReward.description,
            price: newReward.price,
            availability: newReward.availability,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.createReward(newReward: anyNamed('newReward')))
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: newReward.name,
          description: newReward.description,
          price: newReward.price,
          availability: newReward.availability,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('deactivateReward', () {
      test('should return true when successful deactivating reward', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: rewardId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result =
            await rewardController.deactivateReward(rewardId: rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: rewardId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result =
            await rewardController.deactivateReward(rewardId: rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: rewardId))
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.deactivateReward(rewardId: rewardId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: rewardId))
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result =
            await rewardController.deactivateReward(rewardId: rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
