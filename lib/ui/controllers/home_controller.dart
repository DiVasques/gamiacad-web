import 'package:gami_acad_web/ui/controllers/base_controller.dart';

enum SelectedViewState { mission, reward }

class HomeController extends BaseController {
  SelectedViewState _selectedView = SelectedViewState.mission;
  SelectedViewState get selectedView => _selectedView;
  set selectedView(SelectedViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }

  bool _showOpenedDrawer = false;
  bool get showOpenedDrawer => _showOpenedDrawer;

  bool _showDrawerText = false;
  bool get showDrawerText => _showDrawerText;
  set showDrawerText(bool showDrawerText) {
    _showDrawerText = showDrawerText;
    notifyListeners();
  }

  void drawerTapFunction() {
    _showDrawerText = false;
    _showOpenedDrawer = !_showOpenedDrawer;
    notifyListeners();
  }
}
