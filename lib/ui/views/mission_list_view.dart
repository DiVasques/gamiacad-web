import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
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
          headerActions: [
            TextButton.icon(
              onPressed: () =>
                  missionController.selectedView = MissionViewState.create,
              icon: const Icon(
                Icons.add,
              ),
              label: const Text(
                AppTexts.add,
              ),
            ),
          ],
          reloadAction: missionController.getMissions,
          state: missionController.state,
          errorBody: DefaultErrorView(
            message: missionController.errorMessage,
            onPressed: missionController.getMissions,
          ),
          body: GridView.count(
            childAspectRatio: 1.8,
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
                        actions: [
                          mission.active &&
                                  mission.expirationDate.isAfter(DateTime.now())
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                  ),
                                  tooltip: AppTexts.edit,
                                  onPressed: () {
                                    missionController.selectedMission = mission;
                                    missionController.selectedView =
                                        MissionViewState.edit;
                                  },
                                )
                              : const SizedBox(),
                          mission.active
                              ? IconButton(
                                  icon: const Icon(
                                    Icons.cancel_outlined,
                                    color: Colors.red,
                                  ),
                                  tooltip: AppTexts.deactivate,
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => DefaultActionDialog(
                                        titleText: AppTexts.confirmation,
                                        actionText: AppTexts.yes,
                                        action: deactivateAction(
                                          context: context,
                                          missionController: missionController,
                                          missionId: mission.id,
                                        ),
                                        contentText: AppTexts
                                            .missionDeactivateConfirmation,
                                      ),
                                    );
                                  },
                                )
                              : const SizedBox(),
                        ],
                      );
                    },
                  ).toList(),
          ),
        );
      },
    );
  }

  void Function() deactivateAction({
    required BuildContext context,
    required MissionController missionController,
    required String missionId,
  }) {
    return () {
      missionController.deactivateMission(missionId: missionId).then(
        (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(
                result
                    ? AppTexts.missionDeactivateSuccess
                    : AppTexts.missionDeactivateError,
              ),
            ),
          );
          missionController.getMissions();
        },
      );
    };
  }
}
