import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mission_mocks.dart';
import '../../mocks/user_mocks.dart';
import 'mission_controller_test.mocks.dart';

@GenerateMocks([MissionRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('MissionController', () {
    late MissionController missionController;
    late MockMissionRepository missionRepository;

    MissionViewState viewState = MissionViewState.details;

    setUp(() {
      missionRepository = MockMissionRepository();

      when(missionRepository.missions).thenReturn([MissionMocks.mission]);
    });

    group('getMissions', () {
      test('should return missions', () async {
        // Arrange
        when(missionRepository.getMissions())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
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
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: MissionMocks.newMission.name,
          description: MissionMocks.newMission.description,
          points: MissionMocks.newMission.points,
          expirationDate: MissionMocks.newMission.expirationDate,
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
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: MissionMocks.newMission.name,
          description: MissionMocks.newMission.description,
          points: MissionMocks.newMission.points,
          expirationDate: MissionMocks.newMission.expirationDate,
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
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.createMission(
            name: MissionMocks.newMission.name,
            description: MissionMocks.newMission.description,
            points: MissionMocks.newMission.points,
            expirationDate: MissionMocks.newMission.expirationDate,
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
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.createMission(
          name: MissionMocks.newMission.name,
          description: MissionMocks.newMission.description,
          points: MissionMocks.newMission.points,
          expirationDate: MissionMocks.newMission.expirationDate,
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
            missionId: MissionMocks.missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: MissionMocks.missionId,
          name: MissionMocks.editMission.name,
          description: MissionMocks.editMission.description,
          expirationDate: MissionMocks.editMission.expirationDate,
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
            missionId: MissionMocks.missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: MissionMocks.missionId,
          name: MissionMocks.editMission.name,
          description: MissionMocks.editMission.description,
          expirationDate: MissionMocks.editMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.editMission(
            missionId: MissionMocks.missionId,
            name: MissionMocks.editMission.name,
            description: MissionMocks.editMission.description,
            expirationDate: MissionMocks.editMission.expirationDate,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(
          missionRepository.editMission(
            missionId: MissionMocks.missionId,
            editMission: anyNamed('editMission'),
          ),
        ).thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.editMission(
          missionId: MissionMocks.missionId,
          name: MissionMocks.editMission.name,
          description: MissionMocks.editMission.description,
          expirationDate: MissionMocks.editMission.expirationDate,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('deactivateMission', () {
      test('should return true when successful deactivating mission', () async {
        // Arrange
        when(missionRepository.deactivateMission(
                missionId: MissionMocks.missionId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.deactivateMission(
            missionId: MissionMocks.missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(missionRepository.deactivateMission(
                missionId: MissionMocks.missionId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.deactivateMission(
            missionId: MissionMocks.missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(missionRepository.deactivateMission(
                missionId: MissionMocks.missionId))
            .thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.deactivateMission(
              missionId: MissionMocks.missionId);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(missionRepository.deactivateMission(
                missionId: MissionMocks.missionId))
            .thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.deactivateMission(
            missionId: MissionMocks.missionId);

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('refreshMissionData', () {
      test('should return true when successful refreshing mission', () async {
        // Arrange
        when(missionRepository.refreshMission(
                missionId: MissionMocks.missionId))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.refreshMissionData(
          missionId: MissionMocks.missionId,
          viewState: viewState,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(missionController.selectedView, viewState);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        when(missionRepository.refreshMission(
                missionId: MissionMocks.missionId))
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.refreshMissionData(
          missionId: MissionMocks.missionId,
          viewState: viewState,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(missionRepository.refreshMission(
                missionId: MissionMocks.missionId))
            .thenThrow((_) async => UnauthorizedException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act and Assert
        try {
          await missionController.refreshMissionData(
            missionId: MissionMocks.missionId,
            viewState: viewState,
          );
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(missionRepository.refreshMission(
                missionId: MissionMocks.missionId))
            .thenThrow((_) async => ServiceUnavailableException);
        missionController = MissionController(
          userId: UserMocks.userId,
          missionRepository: missionRepository,
        );

        // Act
        var result = await missionController.refreshMissionData(
          missionId: MissionMocks.missionId,
          viewState: viewState,
        );

        // Assert
        expect(missionController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
