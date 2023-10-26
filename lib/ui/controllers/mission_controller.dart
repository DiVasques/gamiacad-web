import 'package:gami_acad_web/ui/controllers/base_controller.dart';

enum MissionViewState { list }

class MissionController extends BaseController {
  MissionViewState _selectedView = MissionViewState.list;
  MissionViewState get selectedView => _selectedView;
  set selectedView(MissionViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }
}
