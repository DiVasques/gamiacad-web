import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_handing_controller.dart';
import 'package:gami_acad_web/ui/views/reward_handing/reward_handing_list_view.dart';
import 'package:provider/provider.dart';

class RewardHandingView extends StatelessWidget {
  final String userId;
  const RewardHandingView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RewardHandingController(userId: userId),
      child: Consumer<RewardHandingController>(
        builder: (context, rewardHandingController, _) {
          return const RewardHandingListView();
        },
      ),
    );
  }
}
