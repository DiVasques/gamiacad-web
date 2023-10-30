import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
import 'package:gami_acad_web/ui/widgets/default_error_view.dart';
import 'package:gami_acad_web/ui/widgets/default_grid_card.dart';
import 'package:provider/provider.dart';

class RewardListView extends StatelessWidget {
  const RewardListView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth ~/ 350;

    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.rewardList,
          state: rewardController.state,
          errorBody: DefaultErrorView(
            message: rewardController.errorMessage,
            onPressed: rewardController.getRewards,
          ),
          headerActions: [
            TextButton.icon(
              onPressed: () =>
                  rewardController.selectedView = RewardViewState.create,
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                AppTexts.add,
              ),
            ),
          ],
          reloadAction: rewardController.getRewards,
          body: GridView.count(
            childAspectRatio: 1.8,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            padding: const EdgeInsets.all(30),
            children: rewardController.state != ViewState.idle
                ? []
                : rewardController.rewards.map(
                    (reward) {
                      return DefaultGridCard(
                        id: reward.id,
                        title: reward.name,
                        subTitle: '#${reward.number.toStringLeadingZeroes()}',
                        trailingTextTitle: '${AppTexts.price}: ',
                        trailingText: reward.price.toStringDecimal(),
                        actions: [
                          reward.active && reward.availability > 0
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  tooltip: AppTexts.edit,
                                  onPressed: () {
                                    rewardController.selectedReward = reward;
                                    rewardController.selectedView =
                                        RewardViewState.edit;
                                  },
                                )
                              : const SizedBox(),
                          reward.active
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),
                                  tooltip: AppTexts.deactivate,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DefaultActionDialog(
                                        titleText: AppTexts.confirmation,
                                        actionText: AppTexts.yes,
                                        action: deactivateAction(
                                          context: context,
                                          rewardController: rewardController,
                                          rewardId: reward.id,
                                        ),
                                        contentText: AppTexts
                                            .rewardDeactivateConfirmation,
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ).toList(),
          ),
        );
      },
    );
  }

  void Function() deactivateAction({
    required BuildContext context,
    required RewardController rewardController,
    required String rewardId,
  }) {
    return () {
      rewardController.deactivateReward(rewardId: rewardId).then(
        (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(
                result
                    ? AppTexts.rewardDeactivateSuccess
                    : AppTexts.rewardDeactivateError,
              ),
            ),
          );
          rewardController.getRewards();
        },
      );
    };
  }
}
