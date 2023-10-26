import 'package:gami_acad_web/ui/controllers/base_controller.dart';

enum RewardViewState { list }

class RewardController extends BaseController {
  RewardViewState _selectedView = RewardViewState.list;
  RewardViewState get selectedView => _selectedView;
  set selectedView(RewardViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }
}
