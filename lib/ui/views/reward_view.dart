import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/views/reward_list_view.dart';
import 'package:provider/provider.dart';

class RewardView extends StatelessWidget {
  const RewardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardController(),
      child: Consumer<RewardController>(
        builder: (context, rewardController, _) {
          return const RewardListView();
        },
      ),
    );
  }
}
