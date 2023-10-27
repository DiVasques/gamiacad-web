import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
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
          body: GridView.count(
            childAspectRatio: 2.0,
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
                        subTitle: '#${reward.number}',
                        trailingTextTitle: '${AppTexts.price}: ',
                        trailingText: reward.price.toStringDecimal(),
                      );
                    },
                  ).toList(),
          ),
        );
      },
    );
  }
}
