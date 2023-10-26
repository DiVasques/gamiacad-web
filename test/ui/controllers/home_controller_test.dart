import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  group('HomeController', () {
    late HomeController homeController;

    setUp(() {
      homeController = HomeController();
    });

    group('drawerTapFunction', () {
      test('should handle drawer tap', () async {
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
  });
}
