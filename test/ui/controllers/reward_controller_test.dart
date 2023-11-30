import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/reward_mocks.dart';
import '../../mocks/user_mocks.dart';
import 'reward_controller_test.mocks.dart';

@GenerateMocks([RewardRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardController', () {
    late RewardController rewardController;
    late MockRewardRepository rewardRepository;

    RewardViewState viewState = RewardViewState.details;

    setUp(() {
      rewardRepository = MockRewardRepository();
      when(rewardRepository.rewards).thenReturn([RewardMocks.reward]);
    });

    group('getRewards', () {
      test('should return rewards', () async {
        // Arrange
        when(rewardRepository.getRewards())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: RewardMocks.newReward.name,
          description: RewardMocks.newReward.description,
          price: RewardMocks.newReward.price,
          availability: RewardMocks.newReward.availability,
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
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: RewardMocks.newReward.name,
          description: RewardMocks.newReward.description,
          price: RewardMocks.newReward.price,
          availability: RewardMocks.newReward.availability,
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
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.createReward(
            name: RewardMocks.newReward.name,
            description: RewardMocks.newReward.description,
            price: RewardMocks.newReward.price,
            availability: RewardMocks.newReward.availability,
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
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.createReward(
          name: RewardMocks.newReward.name,
          description: RewardMocks.newReward.description,
          price: RewardMocks.newReward.price,
          availability: RewardMocks.newReward.availability,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('editReward', () {
      test('should return true when successful editing reward', () async {
        // Arrange
        when(
          rewardRepository.editReward(
            rewardId: RewardMocks.rewardId,
            editReward: anyNamed('editReward'),
          ),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.editReward(
          rewardId: RewardMocks.rewardId,
          name: RewardMocks.editReward.name,
          description: RewardMocks.editReward.description,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result on failed edit reward', () async {
        // Arrange
        when(
          rewardRepository.editReward(
            rewardId: RewardMocks.rewardId,
            editReward: anyNamed('editReward'),
          ),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.editReward(
          rewardId: RewardMocks.rewardId,
          name: RewardMocks.editReward.name,
          description: RewardMocks.editReward.description,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(
          rewardRepository.editReward(
            rewardId: RewardMocks.rewardId,
            editReward: anyNamed('editReward'),
          ),
        ).thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.editReward(
            rewardId: RewardMocks.rewardId,
            name: RewardMocks.editReward.name,
            description: RewardMocks.editReward.description,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(
          rewardRepository.editReward(
            rewardId: RewardMocks.rewardId,
            editReward: anyNamed('editReward'),
          ),
        ).thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.editReward(
          rewardId: RewardMocks.rewardId,
          name: RewardMocks.editReward.name,
          description: RewardMocks.editReward.description,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('deactivateReward', () {
      test('should return true when successful deactivating reward', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: RewardMocks.rewardId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.deactivateReward(
            rewardId: RewardMocks.rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: RewardMocks.rewardId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.deactivateReward(
            rewardId: RewardMocks.rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: RewardMocks.rewardId))
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.deactivateReward(
              rewardId: RewardMocks.rewardId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.deactivateReward(rewardId: RewardMocks.rewardId))
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.deactivateReward(
            rewardId: RewardMocks.rewardId);

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('refreshRewardData', () {
      test('should return true when successful refreshing reward', () async {
        // Arrange
        when(rewardRepository.refreshReward(rewardId: RewardMocks.rewardId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.refreshRewardData(
          rewardId: RewardMocks.rewardId,
          viewState: viewState,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(rewardController.selectedView, viewState);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(rewardRepository.refreshReward(rewardId: RewardMocks.rewardId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.refreshRewardData(
          rewardId: RewardMocks.rewardId,
          viewState: viewState,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(rewardRepository.refreshReward(rewardId: RewardMocks.rewardId))
            .thenThrow((_) async => UnauthorizedException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act and Assert
        try {
          await rewardController.refreshRewardData(
            rewardId: RewardMocks.rewardId,
            viewState: viewState,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(rewardRepository.refreshReward(rewardId: RewardMocks.rewardId))
            .thenThrow((_) async => ServiceUnavailableException);
        rewardController = RewardController(
          userId: UserMocks.userId,
          rewardRepository: rewardRepository,
        );

        // Act
        var result = await rewardController.refreshRewardData(
          rewardId: RewardMocks.rewardId,
          viewState: viewState,
        );

        // Assert
        expect(rewardController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
