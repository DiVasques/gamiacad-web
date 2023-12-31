import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/views/mission/mission_view.dart';
import 'package:gami_acad_web/ui/views/reward/reward_view.dart';
import 'package:gami_acad_web/ui/views/reward_handing/reward_handing_view.dart';
import 'package:gami_acad_web/ui/views/user/user_management_view.dart';
import 'package:gami_acad_web/ui/widgets/home_app_bar.dart';
import 'package:gami_acad_web/ui/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String userId;
  const HomeScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(userId: userId),
      child: Scaffold(
        appBar: HomeAppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 56),
              child: Consumer<HomeController>(
                builder: (context, homeController, _) {
                  switch (homeController.selectedView) {
                    case SelectedViewState.mission:
                      return MissionView(userId: userId);
                    case SelectedViewState.reward:
                      return RewardView(userId: userId);
                    case SelectedViewState.rewardHanding:
                      return RewardHandingView(userId: userId);
                    case SelectedViewState.userManagement:
                      return UserManagementView(userId: userId);
                  }
                },
              ),
            ),
            const HomeDrawer(),
          ],
        ),
      ),
    );
  }
}
