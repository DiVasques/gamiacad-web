import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:intl/date_symbol_data_local.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('pt_BR');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  final Color primaryColor = const Color(0xFF1F5F02);
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamiAcad',
      navigatorKey: globalNavigatorKey,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: primaryColor),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
        ),
        dividerTheme: const DividerThemeData(
          space: 2,
          color: Colors.black54,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: primaryColor,
          elevation: 2,
        ),
        fontFamily: 'Montserrat',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      onGenerateRoute: GenericRouter.generateRoute,
      initialRoute: GenericRouter.loginRoute,
    );
  }
}
