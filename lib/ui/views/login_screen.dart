import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/login_controller.dart';
import 'package:gami_acad_web/ui/views/large_login_screen.dart';
import 'package:gami_acad_web/ui/views/small_login_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    Widget createChild() {
      if (screenWidth < 800) {
        return const SmallLoginScreen();
      }

      if (screenHeight > 500) {
        return const LargeLoginScreen();
      }

      return const SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: LargeLoginScreen(),
      );
    }

    return ChangeNotifierProvider<LoginController>(
      create: (_) => LoginController(),
      child: Material(child: createChild()),
    );
  }
}
