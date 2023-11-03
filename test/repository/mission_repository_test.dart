import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/edit_mission.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/exceptions/forbidden_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/services/gamiacad_dio_client.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mission_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionRepository', () {
    late MissionRepository missionRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    String missionId = 'id';

    Mission mission = Mission(
        id: missionId,
        name: 'name',
        description: 'description',
        number: 1,
        points: 100,
        expirationDate: DateTime.now(),
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        createdBy: 'createdBy',
        participants: ["123"],
        completers: ["456"],
        active: true);

    CreateMission newMission = CreateMission(
      name: 'name',
      description: 'description',
      points: 100,
      expirationDate: DateTime.now(),
    );

    EditMission editMission = EditMission(
      name: 'name',
      description: 'description',
      expirationDate: DateTime.now(),
    );

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
            'missions': [mission.toJson()],
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
        expect(missionRepository.missions[0].id, mission.id);
        expect(missionRepository.missions[0].name, mission.name);
        expect(
          missionRepository.missions[0].description,
          mission.description,
        );
        expect(missionRepository.missions[0].number, mission.number);
        expect(missionRepository.missions[0].points, mission.points);
        expect(missionRepository.missions[0].expirationDate,
            mission.expirationDate);
        expect(missionRepository.missions[0].createdAt, mission.createdAt);
        expect(missionRepository.missions[0].updatedAt, mission.updatedAt);
        expect(missionRepository.missions[0].createdBy, mission.createdBy);
        expect(
            missionRepository.missions[0].participants, mission.participants);
        expect(missionRepository.missions[0].completers, mission.completers);
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
        Mission alteredMission = mission;
        alteredMission.name = 'Edited Name';
        missionRepository.missions = [mission];
        Response response = Response(
          requestOptions: RequestOptions(),
          statusCode: 200,
          statusMessage: 'Success',
          data: alteredMission.toJson(),
        );
        when(gamiAcadDioClient.get(
          path: '/mission/$missionId',
        )).thenAnswer((_) async => response);

        // Act
        final result =
            await missionRepository.refreshMission(missionId: missionId);

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
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.get(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.refreshMission(missionId: missionId);
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
          body: newMission.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result =
            await missionRepository.createMission(newMission: newMission);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(newMission: newMission);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(newMission: newMission);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: newMission.toJson(),
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(newMission: newMission);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.post(
          path: '/mission',
          body: newMission.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.createMission(newMission: newMission);
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
          path: '/mission/$missionId',
          body: editMission.toJson(),
        )).thenAnswer((_) async => response);

        // Act
        final result = await missionRepository.editMission(
            missionId: missionId, editMission: editMission);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/$missionId',
          body: editMission.toJson(),
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
              missionId: missionId, editMission: editMission);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/$missionId',
          body: editMission.toJson(),
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
              missionId: missionId, editMission: editMission);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/$missionId',
          body: editMission.toJson(),
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
              missionId: missionId, editMission: editMission);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.patch(
          path: '/mission/$missionId',
          body: editMission.toJson(),
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.editMission(
              missionId: missionId, editMission: editMission);
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
          path: '/mission/$missionId',
        )).thenAnswer((_) async => response);

        // Act
        final result =
            await missionRepository.deactivateMission(missionId: missionId);

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
      });

      test('should return unauthorized when 401', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 401),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return forbidden', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 403),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, ForbiddenException);
        }
      });

      test('should return service unavailable', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw DioException(
            requestOptions: RequestOptions(),
            response:
                Response(requestOptions: RequestOptions(), statusCode: 404),
          ),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });

      test('should return service unavailable when unknown error', () async {
        // Arrange
        when(gamiAcadDioClient.delete(
          path: '/mission/$missionId',
        )).thenAnswer(
          (_) async => throw Exception(),
        );

        // Act and Assert
        try {
          await missionRepository.deactivateMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, ServiceUnavailableException);
        }
      });
    });
  });
}
