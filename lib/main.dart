import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:gami_acad_web/middlewares/unauthorized_interceptor.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  PlatformDispatcher.instance.onError = UnauthorizedInterceptor.onError;

  runZonedGuarded(
    () => runApp(const MainApp()),
    UnauthorizedInterceptor.onError,
  );
}

class MainApp extends StatelessWidget {
  static const String defaultFontFamily = 'Montserrat';
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamiAcad',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('pt', 'BR'),
      ],
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.primaryColor),
          titleTextStyle: TextStyle(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 25,
            fontFamily: defaultFontFamily,
          ),
          elevation: 1,
          backgroundColor: AppColors.backgroundColor,
          surfaceTintColor: AppColors.backgroundColor,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
        ),
        dividerTheme: const DividerThemeData(
          space: 2,
          color: Colors.black54,
        ),
        iconButtonTheme: IconButtonThemeData(
          style: IconButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            disabledBackgroundColor: AppColors.errorGray,
            iconColor: Colors.white,
            surfaceTintColor: Colors.white,
            textStyle: const TextStyle(
              fontFamily: defaultFontFamily,
              color: Colors.white,
            ),
            foregroundColor: Colors.white,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.primaryColor,
          elevation: 2,
        ),
        snackBarTheme: const SnackBarThemeData(
          behavior: SnackBarBehavior.floating,
          contentTextStyle: TextStyle(
            color: Colors.white,
            fontFamily: defaultFontFamily,
          ),
          width: 400,
        ),
        fontFamily: defaultFontFamily,
        primaryColor: AppColors.primaryColor,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.loginRoute,
    );
  }
}
