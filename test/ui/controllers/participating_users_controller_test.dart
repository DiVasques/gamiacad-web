import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/participating_users_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/mission_mocks.dart';
import '../../mocks/user_mocks.dart';
import 'participating_users_controller_test.mocks.dart';

@GenerateMocks([MissionRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('ParticipatingUsersController', () {
    late ParticipatingUsersController participatingUsersController;
    late MockMissionRepository missionRepository;

    setUp(() {
      missionRepository = MockMissionRepository();

      when(missionRepository.missions).thenReturn([MissionMocks.mission]);
    });

    group('completeMission', () {
      test('should return true when successful completing mission', () async {
        // Arrange
        when(
          missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          ),
        ).thenAnswer(
          (_) async => Result(status: true, message: 'Success'),
        );
        when(
          missionRepository.completeMission(
            userId: UserMocks.user2Id,
            missionId: MissionMocks.missionId,
          ),
        ).thenAnswer(
          (_) async => Result(status: true, message: 'Success'),
        );
        participatingUsersController = ParticipatingUsersController(
          missionRepository: missionRepository,
        );

        // Act
        var result = await participatingUsersController.completeMission(
          users: [UserMocks.user, UserMocks.user2],
          missionId: MissionMocks.missionId,
        );

        // Assert
        expect(participatingUsersController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing at least once',
          () async {
        // Arrange
        when(
          missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          ),
        ).thenAnswer(
          (_) async => Result(status: false, message: 'Error'),
        );
        participatingUsersController = ParticipatingUsersController(
          missionRepository: missionRepository,
        );
        when(
          missionRepository.completeMission(
            userId: UserMocks.user2Id,
            missionId: MissionMocks.missionId,
          ),
        ).thenAnswer(
          (_) async => Result(status: true, message: 'Success'),
        );

        // Act
        var result = await participatingUsersController.completeMission(
          users: [UserMocks.user, UserMocks.user2],
          missionId: MissionMocks.missionId,
        );

        // Assert
        expect(participatingUsersController.state, ViewState.idle);
        expect(result, false);
      });

      test('should return error when there is an exception', () async {
        // Arrange
        when(
          missionRepository.completeMission(
            userId: UserMocks.userId,
            missionId: MissionMocks.missionId,
          ),
        ).thenThrow(
          (_) async => ServiceUnavailableException,
        );
        participatingUsersController = ParticipatingUsersController(
          missionRepository: missionRepository,
        );
        when(
          missionRepository.completeMission(
            userId: UserMocks.user2Id,
            missionId: MissionMocks.missionId,
          ),
        ).thenAnswer(
          (_) async => Result(status: true, message: 'Success'),
        );

        // Act
        var result = await participatingUsersController.completeMission(
          users: [UserMocks.user, UserMocks.user2],
          missionId: MissionMocks.missionId,
        );

        // Assert
        expect(participatingUsersController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
