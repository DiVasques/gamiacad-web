import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/edit_mission.dart';
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

    String missionId = 'missionId';

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
      createdBy: userId,
    );

    EditMission editMission = EditMission(
      name: 'name',
      description: 'description',
      expirationDate: DateTime.now(),
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

      test('should return unsuccessful result on failed create mission',
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

    group('editMission', () {
      test('should return true when successful editing mission', () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: missionId,
          name: editMission.name,
          description: editMission.description,
          expirationDate: editMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result on failed edit mission',
          () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: missionId,
          name: editMission.name,
          description: editMission.description,
          expirationDate: editMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.editMission(
            missionId: missionId,
            name: editMission.name,
            description: editMission.description,
            expirationDate: editMission.expirationDate,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: missionId,
          name: editMission.name,
          description: editMission.description,
          expirationDate: editMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('deactivateMission', () {
      test('should return true when successful deactivating mission', () async {
        // Arrange
        when(missionRepository.deactivateMission(missionId: missionId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result =
            await missionController.deactivateMission(missionId: missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(missionRepository.deactivateMission(missionId: missionId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result =
            await missionController.deactivateMission(missionId: missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(missionRepository.deactivateMission(missionId: missionId))
            .thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.deactivateMission(missionId: missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(missionRepository.deactivateMission(missionId: missionId))
            .thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: userId,
          missionRepository: missionRepository,
        );

        // Act
        var result =
            await missionController.deactivateMission(missionId: missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
