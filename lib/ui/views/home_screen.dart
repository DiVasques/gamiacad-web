import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/views/mission_view.dart';
import 'package:gami_acad_web/ui/views/reward_view.dart';
import 'package:gami_acad_web/ui/widgets/home_app_bar.dart';
import 'package:gami_acad_web/ui/widgets/home_drawer.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => HomeController(),
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
                      return const MissionView();
                    case SelectedViewState.reward:
                      return const RewardView();
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
