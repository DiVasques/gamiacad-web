import 'package:gami_acad_web/repository/models/claimed_reward.dart';
import 'package:gami_acad_web/repository/models/exceptions/service_unavailable_exception.dart';
import 'package:gami_acad_web/repository/models/exceptions/unauthorized_exception.dart';
import 'package:gami_acad_web/repository/models/result.dart';
import 'package:gami_acad_web/repository/reward_repository.dart';
import 'package:gami_acad_web/ui/controllers/base_controller.dart';
import 'package:gami_acad_web/ui/utils/error_messages.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';

class RewardHandingController extends BaseController {
  late String userId;
  late RewardRepository _rewardRepository;

  RewardHandingController({
    required this.userId,
    RewardRepository? rewardRepository,
  }) {
    _rewardRepository = rewardRepository ?? RewardRepository();
    getClaimedRewards();
  }

  List<ClaimedReward> get claimedRewards => _rewardRepository.claimedRewards;

  Future<void> getClaimedRewards() async {
    setState(ViewState.busy);
    try {
      Result result = await _rewardRepository.getClaimedRewards();

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

  Future<bool> handReward({
    required String rewardId,
    required String userId,
  }) async {
    setState(ViewState.busy);
    try {
      Result result = await _rewardRepository.handReward(
        rewardId: rewardId,
        userId: userId,
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
