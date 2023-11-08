import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/models/user.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

class ParticipatingUsersController extends BaseController {
  late MissionRepository _missionRepository;

  ParticipatingUsersController({
    MissionRepository? missionRepository,
  }) {
    _missionRepository = missionRepository ?? MissionRepository();
  }

  final List<User> _selectedUsers = List.empty(growable: true);
  List<User> get selectedUsers => _selectedUsers;
  addSelectedUser(User user) {
    _selectedUsers.add(user);
    notifyListeners();
  }

  removeSelectedUser(User user) {
    _selectedUsers.remove(user);
    notifyListeners();
  }

  Future<bool> completeMission({
    required String missionId,
    required List<User> users,
  }) async {
    setState(ViewState.busy);
    try {
      List<Result> results = await Future.wait(
        users.map(
          (user) => _missionRepository.completeMission(
            missionId: missionId,
            userId: user.id,
          ),
        ),
      );
      return !results.any((result) => result.status == false);
    } catch (e) {
      return false;
    } finally {
      setState(ViewState.idle);
    }
  }
}
