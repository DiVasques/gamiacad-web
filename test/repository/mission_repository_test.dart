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

import 'mission_repository_test.mocks.dart';

@GenerateMocks([GamiAcadDioClient])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionRepository', () {
    late MissionRepository missionRepository;
    late MockGamiAcadDioClient gamiAcadDioClient;

    Mission mission = Mission(
      id: 'id',
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
  });
}
