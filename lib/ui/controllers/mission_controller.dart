import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

enum MissionViewState { list, create }

class MissionController extends BaseController {
  late String userId;
  late MissionRepository _missionRepository;

  MissionViewState _selectedView = MissionViewState.list;
  MissionViewState get selectedView => _selectedView;
  set selectedView(MissionViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }

  MissionController({
    required this.userId,
    MissionRepository? missionRepository,
  }) {
    _missionRepository = missionRepository ?? MissionRepository();
    getMissions();
  }

  List<Mission> get missions => _missionRepository.missions;

  Future<void> getMissions() async {
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.getMissions();

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
