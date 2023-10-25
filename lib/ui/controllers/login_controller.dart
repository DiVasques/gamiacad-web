import 'package:gami_acad_web/repository/auth_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/models/user_access.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

class LoginController extends BaseController {
  late AuthRepository _authRepository;

  LoginController({AuthRepository? authRepository}) {
    _authRepository = authRepository ?? AuthRepository();
  }

  UserAccess get userAccess => _authRepository.user;

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

  bool _loginError = false;
  bool get loginError => _loginError;
  set loginError(bool value) {
    _loginError = value;
    notifyListeners();
  }

  Future<Result> handleSignIn() async {
    setState(ViewState.busy);
    loginError = false;
    try {
      return await _authRepository.loginUser(
        registration: _registration!,
        password: _password!,
      );
    } on UnauthorizedException {
      loginError = true;
      setErrorMessage(ErrorMessages.failedLoginAttempt);
      return Result(status: false, message: ErrorMessages.failedLoginAttempt);
    } catch (error) {
      loginError = true;
      setErrorMessage(ErrorMessages.serviceUnavailable);
      return Result(status: false, message: ErrorMessages.unknownError);
    } finally {
      setState(ViewState.idle);
    }
  }
}
