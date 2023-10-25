import 'package:flutter/material.dart';
import 'package:gami_acad_web/main.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';

class UnauthorizedInterceptor {
  static bool onError(Object? error, StackTrace stack) {
    if (error.runtimeType != UnauthorizedException) {
      return true;
    }
    _handleNavigation();
    _showDialog(error: error);
    return true;
  }

  static void _handleNavigation() {
    Navigator.of(globalNavigatorKey.currentContext!)
        .pushNamedAndRemoveUntil(GenericRouter.loginRoute, (route) => false);
    return;
  }

  static void _showDialog({Object? error}) {
    showDialog(
      context: globalNavigatorKey.currentContext!,
      builder: (context) => AlertDialog(
        title: const Center(
          child: Text(
            AppTexts.loginExpired,
            style: TextStyle(color: Colors.grey),
          ),
        ),
        content: const Text(
          AppTexts.loginExpiredLongText,
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            child: const Text(AppTexts.ok),
            onPressed: () {
              Navigator.of(globalNavigatorKey.currentContext!).pop();
            },
          ),
        ],
      ),
    );
  }
}
