import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/views/home_screen.dart';
import 'package:gami_acad_web/ui/views/login_screen.dart';

class GenericRouter {
  static const String loginRoute = '/login';
  static const String homeRoute = '/';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case loginRoute:
        builder = (BuildContext _) => const LoginScreen();
        break;
      case homeRoute:
        builder = (BuildContext _) => const HomeScreen();
        break;
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
