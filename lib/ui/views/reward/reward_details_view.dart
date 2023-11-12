import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
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
                    bottom: 200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '${AppTexts.price}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        rewardController.selectedReward.price.toStringDecimal(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AppTexts.rewardAvailability}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        rewardController.selectedReward.availability.toString(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AppTexts.description}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        rewardController.selectedReward.description,
                        textAlign: TextAlign.justify,
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
