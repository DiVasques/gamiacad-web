import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../mocks/mission_mocks.dart';
import '../mocks/user_mocks.dart';
import 'mission_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionRepository', () {
    late MissionRepository missionRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    setUp(() {
      gamiAcadDioClient = MockGamiAcadDioClient();
      missionRepository = MissionRepository(
        gamiAcadDioClient: gamiAcadDioClient,
      );
    });

    group('getMissions', () {
      test('should return success getMissions', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: {
            'missions': [MissionMocks.mission.toJson()],
          },
        );
        when(gamiAcadDioClient.get(
          path: '/mission',
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.getMissions();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(missionRepository.missions[0].id, MissionMocks.mission.id);
        expect(missionRepository.missions[0].name, MissionMocks.mission.name);
        expect(
          missionRepository.missions[0].description,
          MissionMocks.mission.description,
        );
        expect(
            missionRepository.missions[0].number, MissionMocks.mission.number);
        expect(
            missionRepository.missions[0].points, MissionMocks.mission.points);
        expect(missionRepository.missions[0].expirationDate,
            MissionMocks.mission.expirationDate);
        expect(missionRepository.missions[0].createdAt,
            MissionMocks.mission.createdAt);
        expect(missionRepository.missions[0].updatedAt,
            MissionMocks.mission.updatedAt);
        expect(missionRepository.missions[0].createdBy,
            MissionMocks.mission.createdBy);
        expect(missionRepository.missions[0].participants,
            MissionMocks.mission.participants);
        expect(missionRepository.missions[0].completers,
            MissionMocks.mission.completers);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getMissions();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getMissions();
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.getMissions();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.getMissions();
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('refreshMission', () {
      test('should return success refreshMission', () async {
        // Arrange
        Mission alteredMission = MissionMocks.mission;
        alteredMission.name = 'Edited Name';
        missionRepository.missions = [MissionMocks.mission];
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: alteredMission.toJson(),
        );
        when(gamiAcadDioClient.get(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.refreshMission(
            missionId: MissionMocks.missionId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(missionRepository.missions[0].id, alteredMission.id);
        expect(missionRepository.missions[0].name, alteredMission.name);
        expect(
          missionRepository.missions[0].description,
          alteredMission.description,
        );
        expect(missionRepository.missions[0].number, alteredMission.number);
        expect(missionRepository.missions[0].points, alteredMission.points);
        expect(missionRepository.missions[0].expirationDate,
            alteredMission.expirationDate);
        expect(
            missionRepository.missions[0].createdAt, alteredMission.createdAt);
        expect(
            missionRepository.missions[0].updatedAt, alteredMission.updatedAt);
        expect(
            missionRepository.missions[0].createdBy, alteredMission.createdBy);
        expect(missionRepository.missions[0].participants,
            alteredMission.participants);
        expect(missionRepository.missions[0].completers,
            alteredMission.completers);
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('createMission', () {
      test('should return success createMission', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 201,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: MissionMocks.newMission.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.createMission(
            newMission: MissionMocks.newMission);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: MissionMocks.newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(
              newMission: MissionMocks.newMission);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: MissionMocks.newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(
              newMission: MissionMocks.newMission);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: MissionMocks.newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(
              newMission: MissionMocks.newMission);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: MissionMocks.newMission.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(
              newMission: MissionMocks.newMission);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('editMission', () {
      test('should return success editMission', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}',
          body: MissionMocks.editMission.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.editMission(
          missionId: MissionMocks.missionId,
          editMission: MissionMocks.editMission,
        );

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}',
          body: MissionMocks.editMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: MissionMocks.editMission,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}',
          body: MissionMocks.editMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: MissionMocks.editMission,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}',
          body: MissionMocks.editMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: MissionMocks.editMission,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}',
          body: MissionMocks.editMission.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: MissionMocks.editMission,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('deactivateMission', () {
      test('should return success deactivateMission', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.delete(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.deactivateMission(
            missionId: MissionMocks.missionId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/${MissionMocks.missionId}',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });

    group('completeMission', () {
      test('should return success completeMission', () async {
        // Arrange
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 204,
          statusMessage: 'Success',
        );
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}/${UserMocks.userId}',
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.completeMission(
            userId: UserMocks.userId, missionId: MissionMocks.missionId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}/${UserMocks.userId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}/${UserMocks.userId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          );
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}/${UserMocks.userId}',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/${MissionMocks.missionId}/${UserMocks.userId}',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          );
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
