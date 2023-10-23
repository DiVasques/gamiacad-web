import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/views/login_screen.dart';

class GenericRouter {
  static const String loginRoute = '/login';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    WidgetBuilder builder;
    switch (settings.name) {
      case loginRoute:
        builder = (BuildContext _) => const LoginScreen();
        break;
      default:
        return MaterialPageRoute(
          builder: (_) {
            return Scaffold(
              body: Center(
                child: Text('BUG: Rota não definida para ${settings.name}'),
              ),
            );
          },
        );
    }
    return MaterialPageRoute(builder: builder, settings: settings);
  }
}
