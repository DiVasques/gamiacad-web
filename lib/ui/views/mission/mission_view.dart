import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/views/mission/mission_create_view.dart';
import 'package:gami_acad_web/ui/views/mission/mission_details_view.dart';
import 'package:gami_acad_web/ui/views/mission/mission_edit_view.dart';
import 'package:gami_acad_web/ui/views/mission/mission_list_view.dart';
import 'package:provider/provider.dart';

class MissionView extends StatelessWidget {
  final String userId;
  const MissionView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MissionController(userId: userId),
      child: Consumer<MissionController>(
        builder: (context, missionController, _) {
          switch (missionController.selectedView) {
            case MissionViewState.list:
              return const MissionListView();
            case MissionViewState.create:
              return const MissionCreateView();
            case MissionViewState.edit:
              return const MissionEditView();
            case MissionViewState.details:
              return const MissionDetailsView();
          }
        },
      ),
    );
  }
}
