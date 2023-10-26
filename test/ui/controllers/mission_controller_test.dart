import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
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

    setUp(() {
      missionRepository = MockMissionRepository();
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
  });
}
