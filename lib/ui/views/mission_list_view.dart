import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:provider/provider.dart';

class MissionListView extends StatelessWidget {
  const MissionListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
        builder: (context, missionController, _) {
      return BaseSectionView(
        viewTitle: AppTexts.missionList,
        state: missionController.state,
        errorBody: const Center(
          child: Text('erro'),
        ),
        body: const Text(AppTexts.missionList),
      );
    });
  }
}
