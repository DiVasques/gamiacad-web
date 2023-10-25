import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/auth_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/ui/controllers/login_controller.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_controller_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('LoginController', () {
    late LoginController loginController;
    late MockAuthRepository authRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      loginController = LoginController(
        authRepository: authRepository,
      );
    });

    group('handleSignIn', () {
      test('should return success login', () async {
        // Arrange
        loginController.registration = 'valid_registration';
        loginController.password = 'valid_password';

        when(authRepository.loginUser(
                registration: 'valid_registration', password: 'valid_password'))
            .thenAnswer((_) async => Result(status: true, message: 'Success'));

        // Act
        final result = await loginController.handleSignIn();

        // Assert
        expect(result.status, true);
        expect(result.message, 'Success');
        expect(loginController.state, ViewState.idle);
        expect(loginController.loginError, false);
      });

      test('should return unsuccessful result on failed login attempt',
          () async {
        // Arrange
        loginController.registration = 'valid_registration';
        loginController.password = 'invalid_password';

        when(authRepository.loginUser(
                registration: 'valid_registration',
                password: 'invalid_password'))
            .thenAnswer((_) async => throw UnauthorizedException());

        // Act
        final result = await loginController.handleSignIn();

        // Assert
        expect(result.status, false);
        expect(result.message, ErrorMessages.failedLoginAttempt);
        expect(loginController.state, ViewState.idle);
        expect(loginController.loginError, true);
      });

      test('should return unsuccessful result on service unavailable',
          () async {
        // Arrange
        loginController.registration = 'valid_registration';
        loginController.password = 'valid_password';

        when(authRepository.loginUser(
                registration: 'valid_registration', password: 'valid_password'))
            .thenAnswer((_) async => throw Exception());

        // Act
        final result = await loginController.handleSignIn();

        // Assert
        expect(result.status, false);
        expect(result.message, ErrorMessages.unknownError);
        expect(loginController.state, ViewState.idle);
        expect(loginController.loginError, true);
      });
    });
  });
}
