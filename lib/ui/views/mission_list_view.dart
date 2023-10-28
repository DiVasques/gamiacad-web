import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_error_view.dart';
import 'package:gami_acad_web/ui/widgets/default_grid_card.dart';
import 'package:provider/provider.dart';

class MissionListView extends StatelessWidget {
  const MissionListView({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenWidth ~/ 350;

    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.missionList,
          headerAction: () =>
              missionController.selectedView = MissionViewState.create,
          actionButtonText: AppTexts.add,
          state: missionController.state,
          errorBody: DefaultErrorView(
            message: missionController.errorMessage,
            onPressed: missionController.getMissions,
          ),
          body: GridView.count(
            childAspectRatio: 2.0,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 30,
            mainAxisSpacing: 30,
            padding: const EdgeInsets.all(30),
            children: missionController.state != ViewState.idle
                ? []
                : missionController.missions.map(
                    (mission) {
                      return DefaultGridCard(
                        id: mission.id,
                        title: mission.name,
                        subTitle: '#${mission.number.toStringLeadingZeroes()}',
                        trailingTextTitle: '${AppTexts.points}: ',
                        trailingText: mission.points.toStringDecimal(),
                      );
                    },
                  ).toList(),
          ),
        );
      },
    );
  }
}
