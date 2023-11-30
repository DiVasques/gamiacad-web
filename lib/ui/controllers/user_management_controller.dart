import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/models/user_with_privilege.dart';
import 'package:gami_acad_web/repository/user_repository.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

class UserManagementController extends BaseController {
  late String userId;
  late UserRepository _userRepository;

  UserManagementController({
    required this.userId,
    UserRepository? userRepository,
  }) {
    _userRepository = userRepository ?? UserRepository();
    getUsers();
  }

  List<UserWithPrivilege> get users => _userRepository.users;

  Future<void> getUsers() async {
    setState(ViewState.busy);
    try {
      Result result = await _userRepository.getUsers();

      if (result.status) {
        setState(ViewState.idle);
        return;
      }
      setErrorMessage(result.message ?? '');
      setState(ViewState.error);
    } on UnauthorizedException {
      rethrow;
    } on ServiceUnavailableException catch (e) {
      setErrorMessage(e.toString());
      setState(ViewState.error);
    } catch (e) {
      setErrorMessage(ErrorMessages.unknownError);
      setState(ViewState.error);
    }
  }
}
