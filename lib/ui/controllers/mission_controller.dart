import 'package:gami_acad_web/repository/mission_repository.dart';
import 'package:gami_acad_web/repository/models/create_mission.dart';
import 'package:gami_acad_web/repository/models/edit_mission.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/mission.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

enum MissionViewState { list, create, edit, details }

class MissionController extends BaseController {
  late String userId;
  late MissionRepository _missionRepository;

  MissionViewState _selectedView = MissionViewState.list;
  MissionViewState get selectedView => _selectedView;
  set selectedView(MissionViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }

  late Mission _selectedMission;
  Mission get selectedMission => _selectedMission;
  set selectedMission(Mission mission) {
    _selectedMission = mission;
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

  Future<bool> createMission({
    required String name,
    required String description,
    required int points,
    required DateTime expirationDate,
  }) async {
    CreateMission newMission = CreateMission(
      name: name,
      description: description,
      points: points,
      expirationDate: expirationDate,
      createdBy: userId,
    );
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.createMission(
        newMission: newMission,
      );
      return result.status;
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      return false;
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<bool> editMission({
    required String missionId,
    required String name,
    required String description,
    required DateTime expirationDate,
  }) async {
    EditMission newMission = EditMission(
      name: name,
      description: description,
      expirationDate: expirationDate,
    );
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.editMission(
        missionId: missionId,
        editMission: newMission,
      );
      return result.status;
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      return false;
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<bool> deactivateMission({
    required String missionId,
  }) async {
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.deactivateMission(
        missionId: missionId,
      );
      return result.status;
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      return false;
    } finally {
      setState(ViewState.idle);
    }
  }

  Future<bool> refreshMissionData({
    required String missionId,
    required MissionViewState viewState,
  }) async {
    setState(ViewState.busy);
    try {
      Result result = await _missionRepository.refreshMission(
        missionId: missionId,
      );
      return result.status;
    } on UnauthorizedException {
      rethrow;
    } catch (e) {
      return false;
    } finally {
      selectedMission = missions.singleWhere(
        (mission) => mission.id == missionId,
      );
      setState(ViewState.idle);
      selectedView = viewState;
    }
  }
}
