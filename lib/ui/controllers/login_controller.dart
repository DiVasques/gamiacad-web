import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

class LoginController extends BaseController {
  String? _registration;
  String? get registration => _registration;
  set registration(String? value) {
    _registration = value;
    notifyListeners();
  }

  String? _password;
  String? get password => _password;
  set password(String? value) {
    _password = value;
    notifyListeners();
  }

  bool _wrongCredentials = false;
  bool get wrongCredentials => _wrongCredentials;
  set wrongCredentials(bool value) {
    _wrongCredentials = value;
    notifyListeners();
  }

  Future<Result> handleSingIn() async {
    setState(ViewState.busy);
    _wrongCredentials = false;
    await Future.delayed(const Duration(seconds: 3));
    try {
      return Result(status: true);
    } catch (error) {
      wrongCredentials = true;
      return Result(status: false, message: ErrorMessages.unknownError);
    } finally {
      setState(ViewState.idle);
    }
  }
}
