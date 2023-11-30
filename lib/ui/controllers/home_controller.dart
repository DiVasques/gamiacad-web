import 'package:gami_acad_web/repository/auth_repository.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

enum SelectedViewState { mission, reward, rewardHanding }

class HomeController extends BaseController {
  late String userId;
  late AuthRepository _authRepository;

  SelectedViewState _selectedView = SelectedViewState.mission;
  SelectedViewState get selectedView => _selectedView;
  set selectedView(SelectedViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }

  HomeController({
    required this.userId,
    AuthRepository? authRepository,
  }) {
    _authRepository = authRepository ?? AuthRepository();
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

  Future<void> logoutUser() async {
    setState(ViewState.busy);
    try {
      await _authRepository.logoutUser();
    } catch (e) {
      //Should go idle even with errors
    } finally {
      setState(ViewState.idle);
    }
  }
}
