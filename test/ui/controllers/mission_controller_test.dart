import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'mission_controller_test.mocks.dart';

@GenerateMocks([MissionRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionController', () {
    late MissionController missionController;
    late MockMissionRepository missionRepository;

    String userId = 'userId';

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

    CreateMission newMission = CreateMission(
      name: 'name',
      description: 'description',
      points: 100,
      expirationDate: DateTime.now(),
      createdBy: userId,
    );

    setUp(() {
      missionRepository = MockMissionRepository();

      when(missionRepository.missions).thenReturn([mission]);
    });

    group('getMissions', () {
      test('should return missions', () async {
        // Arrange
        when(missionRepository.getMissions())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        await missionController.getMissions();

        // Assert
        expect(missionController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get missions',
          () async {
        // Arrange
        when(missionRepository.getMissions())
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        await missionController.getMissions();

        // Assert
        expect(missionController.errorMessage, 'Error');
        expect(missionController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(missionRepository.getMissions())
            .thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.getMissions();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(missionRepository.getMissions())
            .thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        await missionController.getMissions();

        // Assert
        expect(missionController.state, ViewState.error);
      });
    });
    group('createMission', () {
      test('should return true when successful creating mission', () async {
        // Arrange
        when(missionRepository.createMission(
                newMission: anyNamed('newMission')))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: newMission.name,
          description: newMission.description,
          points: newMission.points,
          expirationDate: newMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result on failed get missions',
          () async {
        // Arrange
        when(missionRepository.createMission(
                newMission: anyNamed('newMission')))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: newMission.name,
          description: newMission.description,
          points: newMission.points,
          expirationDate: newMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(missionRepository.createMission(
                newMission: anyNamed('newMission')))
            .thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.createMission(
            name: newMission.name,
            description: newMission.description,
            points: newMission.points,
            expirationDate: newMission.expirationDate,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(missionRepository.createMission(
                newMission: anyNamed('newMission')))
            .thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: newMission.name,
          description: newMission.description,
          points: newMission.points,
          expirationDate: newMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
