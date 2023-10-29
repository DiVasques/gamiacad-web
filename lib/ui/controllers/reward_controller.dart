import 'package:gami_acad_web/repository/models/create_reward.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/models/reward.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

enum RewardViewState { list, create }

class RewardController extends BaseController {
  late String userId;
  late RewardRepository _rewardRepository;

  RewardViewState _selectedView = RewardViewState.list;
  RewardViewState get selectedView => _selectedView;
  set selectedView(RewardViewState selectedView) {
    _selectedView = selectedView;
    notifyListeners();
  }

  RewardController({
    required this.userId,
    RewardRepository? rewardRepository,
  }) {
    _rewardRepository = rewardRepository ?? RewardRepository();
    getRewards();
  }

  List<Reward> get rewards => _rewardRepository.rewards;

  Future<void> getRewards() async {
    setState(ViewState.busy);
    try {
      Result result = await _rewardRepository.getRewards();

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

  Future<bool> createReward({
    required String name,
    required String description,
    required int price,
    required int availability,
  }) async {
    CreateReward newReward = CreateReward(
      name: name,
      description: description,
      price: price,
      availability: availability,
    );
    setState(ViewState.busy);
    try {
      Result result = await _rewardRepository.createReward(
        newReward: newReward,
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
}
