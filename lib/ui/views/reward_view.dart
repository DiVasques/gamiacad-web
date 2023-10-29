import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/views/reward_create_view.dart';
import 'package:gami_acad_web/ui/views/reward_list_view.dart';
import 'package:provider/provider.dart';

class RewardView extends StatelessWidget {
  final String userId;
  const RewardView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardController(userId: userId),
      child: Consumer<RewardController>(
        builder: (context, rewardController, _) {
          switch (rewardController.selectedView) {
            case RewardViewState.list:
              return const RewardListView();
            case RewardViewState.create:
              return const RewardCreateView();
          }
        },
      ),
    );
  }
}
