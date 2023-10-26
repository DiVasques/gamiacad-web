import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:provider/provider.dart';

class RewardListView extends StatelessWidget {
  const RewardListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(builder: (context, rewardController, _) {
      return BaseSectionView(
        viewTitle: AppTexts.rewardList,
        state: rewardController.state,
        errorBody: const Center(
          child: Text('erro'),
        ),
        body: const Text(AppTexts.rewardList),
      );
    });
  }
}
