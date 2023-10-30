import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/repository/auth_repository.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home_controller_test.mocks.dart';

@GenerateMocks([AuthRepository])
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('HomeController', () {
    late HomeController homeController;
    late MockAuthRepository authRepository;

    String userId = 'userId';

    setUp(() {
      authRepository = MockAuthRepository();
    });

    group('drawerTapFunction', () {
      test('should handle drawer tap', () async {
        homeController = HomeController(
          userId: userId,
          authRepository: authRepository,
        );
        // Act 1
        homeController.drawerTapFunction();
        // Assert 1
        expect(homeController.state, ViewState.idle);
        expect(homeController.showOpenedDrawer, true);
        expect(homeController.showDrawerText, false);

        // Arrange 2
        homeController.showDrawerText = true;
        // Act 2
        homeController.drawerTapFunction();
        // Assert 2
        expect(homeController.state, ViewState.idle);
        expect(homeController.showOpenedDrawer, false);
        expect(homeController.showDrawerText, false);
      });
    });

    group('logoutUser', () {
      test('should logout user', () async {
        // Arrange
        when(authRepository.logoutUser())
            .thenAnswer((_) async => Result(status: true, message: 'Success'));
        homeController = HomeController(
          userId: userId,
          authRepository: authRepository,
        );

        // Act
        await homeController.logoutUser();

        // Assert
        expect(homeController.state, ViewState.idle);
      });

      test('should go idle even with errors', () async {
        // Arrange
        when(authRepository.logoutUser())
            .thenAnswer((_) async => throw Exception());
        homeController = HomeController(
          userId: userId,
          authRepository: authRepository,
        );

        // Act
        await homeController.logoutUser();

        // Assert
        expect(homeController.state, ViewState.idle);
      });
    });
  });
}
