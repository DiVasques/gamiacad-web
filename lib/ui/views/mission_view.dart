import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/views/mission_list_view.dart';
import 'package:provider/provider.dart';

class MissionView extends StatelessWidget {
  const MissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionController(),
      child: Consumer<MissionController>(
        builder: (context, missionController, _) {
          return const MissionListView();
        },
      ),
    );
  }
}
