import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/create_reward.dart';
import 'package:gami_acad_web/repository/models/reward.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'reward_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('RewardRepository', () {
    late RewardRepository rewardRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

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
      gamiAcadDioClient = MockGamiAcadDioClient();
      rewardRepository = RewardRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('Rewards', () {
      test('should return success Rewards', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'rewards': [reward.toJson()],
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
        expect(rewardRepository.rewards[0].id, reward.id);
        expect(rewardRepository.rewards[0].name, reward.name);
        expect(
          rewardRepository.rewards[0].description,
          reward.description,
        );
        expect(rewardRepository.rewards[0].number, reward.number);
        expect(rewardRepository.rewards[0].price, reward.price);
        expect(rewardRepository.rewards[0].availability, reward.availability);
        expect(rewardRepository.rewards[0].createdAt, reward.createdAt);
        expect(rewardRepository.rewards[0].updatedAt, reward.updatedAt);
        expect(rewardRepository.rewards[0].claimers, reward.claimers);
        expect(rewardRepository.rewards[0].handed, reward.handed);
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
          body: newReward.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result =
            await rewardRepository.createReward(newReward: newReward);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: newReward);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: newReward);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: newReward.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: newReward);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/reward',
          body: newReward.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.createReward(newReward: newReward);
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
          path: '/reward/$rewardId',
        )).thenAnswer((_) async => response);

        // Act
        final result =
            await rewardRepository.deactivateReward(rewardId: rewardId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/$rewardId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(rewardId: rewardId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/$rewardId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(rewardId: rewardId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/$rewardId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(rewardId: rewardId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/reward/$rewardId',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await rewardRepository.deactivateReward(rewardId: rewardId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
