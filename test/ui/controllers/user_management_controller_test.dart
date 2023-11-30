import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/user_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/user_management_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../mocks/user_mocks.dart';
import 'user_management_controller_test.mocks.dart';

@GenerateMocks([UserRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('UserManagementController', () {
    late UserManagementController userManagementController;
    late MockUserRepository userRepository;

    setUp(() {
      userRepository = MockUserRepository();

      when(userRepository.users).thenReturn([UserMocks.userWithPrivilege]);
    });

    group('getUsers', () {
      test('should return users', () async {
        // Arrange
        when(userRepository.getUsers())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        await userManagementController.getUsers();

        // Assert
        expect(userManagementController.state, ViewState.idle);
      });

      test('should return unsuccessful result on failed get users', () async {
        // Arrange
        when(userRepository.getUsers())
            .thenAnswer((_) async => Result(status: false, message: 'Error'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        await userManagementController.getUsers();

        // Assert
        expect(userManagementController.errorMessage, 'Error');
        expect(userManagementController.state, ViewState.error);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        when(userRepository.getUsers())
            .thenThrow((_) async => UnauthorizedException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act and Assert
        try {
          await userManagementController.getUsers();
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        when(userRepository.getUsers())
            .thenThrow((_) async => ServiceUnavailableException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        await userManagementController.getUsers();

        // Assert
        expect(userManagementController.state, ViewState.error);
      });
    });

    group('updateUserStatus', () {
      test('should return true when successful updating user privileges',
          () async {
        // Arrange
        bool active = true;
        when(
          userRepository.updateUserStatus(
              userId: UserMocks.userId, active: active),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserStatus(
            userId: UserMocks.userId, active: active);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        bool active = true;
        when(
          userRepository.updateUserStatus(
              userId: UserMocks.userId, active: active),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserStatus(
            userId: UserMocks.userId, active: active);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        bool active = true;
        when(
          userRepository.updateUserStatus(
              userId: UserMocks.userId, active: active),
        ).thenThrow((_) async => UnauthorizedException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act and Assert
        try {
          await userManagementController.updateUserStatus(
              userId: UserMocks.userId, active: active);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        bool active = true;
        when(
          userRepository.updateUserStatus(
              userId: UserMocks.userId, active: active),
        ).thenThrow((_) async => ServiceUnavailableException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserStatus(
            userId: UserMocks.userId, active: active);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, false);
      });
    });

    group('updateUserPrivileges', () {
      test('should return true when successful updating user privileges',
          () async {
        // Arrange
        bool admin = true;
        when(
          userRepository.updateUserPrivileges(
              userId: UserMocks.userId, admin: admin),
        ).thenAnswer((_) async => Result(status: true, message: 'Success'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserPrivileges(
            userId: UserMocks.userId, admin: admin);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, true);
      });

      test('should return unsuccessful result when failing', () async {
        // Arrange
        bool admin = true;
        when(
          userRepository.updateUserPrivileges(
              userId: UserMocks.userId, admin: admin),
        ).thenAnswer((_) async => Result(status: false, message: 'Error'));
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserPrivileges(
            userId: UserMocks.userId, admin: admin);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, false);
      });

      test('should throw when unauthorized', () async {
        // Arrange
        bool admin = true;
        when(
          userRepository.updateUserPrivileges(
              userId: UserMocks.userId, admin: admin),
        ).thenThrow((_) async => UnauthorizedException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act and Assert
        try {
          await userManagementController.updateUserPrivileges(
              userId: UserMocks.userId, admin: admin);
        } catch (e) {
          expect(e.runtimeType, UnauthorizedException);
        }
      });

      test('should return error when another exception', () async {
        // Arrange
        bool admin = true;
        when(
          userRepository.updateUserPrivileges(
              userId: UserMocks.userId, admin: admin),
        ).thenThrow((_) async => ServiceUnavailableException);
        userManagementController = UserManagementController(
          userId: UserMocks.userId,
          userRepository: userRepository,
        );

        // Act
        var result = await userManagementController.updateUserPrivileges(
            userId: UserMocks.userId, admin: admin);

        // Assert
        expect(userManagementController.state, ViewState.idle);
        expect(result, false);
      });
    });
  });
}
