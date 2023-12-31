import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
import 'package:gami_acad_web/ui/widgets/handed_user_info.dart';
import 'package:gami_acad_web/ui/widgets/reward_infos.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class RewardDetailsView extends StatelessWidget {
  final double maxViewItemsWidth = 600;
  const RewardDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        return BaseSectionView(
          viewTitle: rewardController.selectedReward.name,
          reloadAction: () {
            rewardController.refreshRewardData(
              rewardId: rewardController.selectedReward.id,
              viewState: RewardViewState.details,
            );
          },
          headerActions: [
            rewardController.selectedReward.active &&
                    rewardController.selectedReward.availability > 0
                ? TextButton.icon(
                    onPressed: () =>
                        rewardController.selectedView = RewardViewState.edit,
                    icon: const Icon(
                      Icons.edit,
                    ),
                    label: const Text(
                      AppTexts.edit,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.errorGray,
                    ),
                  )
                : const SizedBox(),
            rewardController.selectedReward.active
                ? TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DefaultActionDialog(
                          titleText: AppTexts.confirmation,
                          actionText: AppTexts.yes,
                          action: deactivateAction(
                            context: context,
                            rewardController: rewardController,
                            rewardId: rewardController.selectedReward.id,
                          ),
                          contentText: AppTexts.rewardDeactivateConfirmation,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    ),
                    label: const Text(
                      AppTexts.deactivate,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  )
                : const SizedBox()
          ],
          state: rewardController.state,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '#${rewardController.selectedReward.number.toStringLeadingZeroes()}',
                ),
                const Divider(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      spacing: 100,
                      runSpacing: 20,
                      children: [
                        RewardInfos(maxViewItemsWidth: maxViewItemsWidth),
                        HandedUserInfo(maxViewItemsWidth: maxViewItemsWidth),
                      ],
                    ),
                  ),
                ),
                const Gap(20),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.errorGray,
                  ),
                  onPressed: () {
                    rewardController.getRewards();
                    rewardController.selectedView = RewardViewState.list;
                  },
                  child: const Text(AppTexts.back),
                ),
                const Gap(20),
              ],
            ),
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
          if (result) {
            rewardController.selectedReward.active = false;
          }
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
