import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/reward_mocks.dart';
import '../mocks/user_mocks.dart';
import 'reward_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardRepository', () {
    late RewardRepository rewardRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      rewardRepository = RewardRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('getRewards', () {
      test('should return success Rewards', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'rewards': [RewardMocks.reward.toJson()],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/reward',
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.getRewards();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(rewardRepository.rewards[0].id, RewardMocks.reward.id);
        expect(rewardRepository.rewards[0].name, RewardMocks.reward.name);
        expect(
          rewardRepository.rewards[0].description,
          RewardMocks.reward.description,
        );
        expect(rewardRepository.rewards[0].number, RewardMocks.reward.number);
        expect(rewardRepository.rewards[0].price, RewardMocks.reward.price);
        expect(rewardRepository.rewards[0].availability,
            RewardMocks.reward.availability);
        expect(rewardRepository.rewards[0].createdAt,
            RewardMocks.reward.createdAt);
        expect(rewardRepository.rewards[0].updatedAt,
            RewardMocks.reward.updatedAt);
        expect(rewardRepository.rewards[0].claimers[0].id,
            RewardMocks.reward.claimers[0].id);
        expect(rewardRepository.rewards[0].claimers[0].date,
            RewardMocks.reward.claimers[0].date);
        expect(rewardRepository.rewards[0].handed[0].id,
            RewardMocks.reward.handed[0].id);
        expect(rewardRepository.rewards[0].handed[0].date,
            RewardMocks.reward.handed[0].date);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getRewards();
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getRewards();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.getRewards();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('getClaimedRewards', () {
      test('should return success Rewards', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'rewards': [RewardMocks.claimedReward.toJson()],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/reward/claimed',
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.getClaimedRewards();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(rewardRepository.claimedRewards[0].id,
            RewardMocks.claimedReward.id);
        expect(rewardRepository.claimedRewards[0].name,
            RewardMocks.claimedReward.name);
        expect(rewardRepository.claimedRewards[0].number,
            RewardMocks.claimedReward.number);
        expect(rewardRepository.claimedRewards[0].price,
            RewardMocks.claimedReward.price);
        expect(rewardRepository.claimedRewards[0].claimDate,
            RewardMocks.claimedReward.claimDate);
        expect(rewardRepository.claimedRewards[0].claimer.id,
            RewardMocks.claimedReward.claimer.id);
        expect(rewardRepository.claimedRewards[0].claimer.name,
            RewardMocks.claimedReward.claimer.name);
        expect(rewardRepository.claimedRewards[0].claimer.registration,
            RewardMocks.claimedReward.claimer.registration);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward/claimed',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward/claimed',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward/claimed',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/reward/claimed',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.getClaimedRewards();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('createReward', () {
      test('should return success createReward', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 201,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: RewardMocks.newReward.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.createReward(
            newReward: RewardMocks.newReward);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: RewardMocks.newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: RewardMocks.newReward);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: RewardMocks.newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: RewardMocks.newReward);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: RewardMocks.newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: RewardMocks.newReward);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: RewardMocks.newReward.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: RewardMocks.newReward);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('editReward', () {
      test('should return success editReward', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.patch(
          path: '/reward/${RewardMocks.rewardId}',
          body: RewardMocks.editReward.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.editReward(
            rewardId: RewardMocks.rewardId, editReward: RewardMocks.editReward);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/reward/${RewardMocks.rewardId}',
          body: RewardMocks.editReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.editReward(
              rewardId: RewardMocks.rewardId,
              editReward: RewardMocks.editReward);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/reward/${RewardMocks.rewardId}',
          body: RewardMocks.editReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.editReward(
              rewardId: RewardMocks.rewardId,
              editReward: RewardMocks.editReward);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/reward/${RewardMocks.rewardId}',
          body: RewardMocks.editReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.editReward(
              rewardId: RewardMocks.rewardId,
              editReward: RewardMocks.editReward);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/reward/${RewardMocks.rewardId}',
          body: RewardMocks.editReward.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.editReward(
              rewardId: RewardMocks.rewardId,
              editReward: RewardMocks.editReward);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('deactivateReward', () {
      test('should return success deactivateReward', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.delete(
          path: '/reward/${RewardMocks.rewardId}',
        )).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.deactivateReward(
            rewardId: RewardMocks.rewardId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/${RewardMocks.rewardId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(
              rewardId: RewardMocks.rewardId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/${RewardMocks.rewardId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(
              rewardId: RewardMocks.rewardId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/${RewardMocks.rewardId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(
              rewardId: RewardMocks.rewardId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/${RewardMocks.rewardId}',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(
              rewardId: RewardMocks.rewardId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('handReward', () {
      test('should return success handReward', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(
          gamiAcadDioClient.patch(
            path: '/reward/${RewardMocks.rewardId}/${UserMocks.userId}',
          ),
        ).thenAnswer((_) async => response);

        // Act
        final result = await rewardRepository.handReward(
          rewardId: RewardMocks.rewardId,
          userId: UserMocks.userId,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(
          gamiAcadDioClient.patch(
            path: '/reward/${RewardMocks.rewardId}/${UserMocks.userId}',
          ),
        ).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(
          gamiAcadDioClient.patch(
            path: '/reward/${RewardMocks.rewardId}/${UserMocks.userId}',
          ),
        ).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(
          gamiAcadDioClient.patch(
            path: '/reward/${RewardMocks.rewardId}/${UserMocks.userId}',
          ),
        ).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(
          gamiAcadDioClient.patch(
            path: '/reward/${RewardMocks.rewardId}/${UserMocks.userId}',
          ),
        ).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.handReward(
            rewardId: RewardMocks.rewardId,
            userId: UserMocks.userId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
