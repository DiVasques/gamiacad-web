import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
import 'package:provider/provider.dart';

class MissionDetailsView extends StatelessWidget {
  const MissionDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        return BaseSectionView(
          viewTitle: missionController.selectedMission.name,
          headerActions: [
            missionController.selectedMission.active &&
                    missionController.selectedMission.expirationDate
                        .isAfter(DateTime.now())
                ? TextButton.icon(
                    onPressed: () =>
                        missionController.selectedView = MissionViewState.edit,
                    icon: const Icon(
                      Icons.edit,
                    ),
                    label: const Text(
                      AppTexts.edit,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.errorGray,
                    ),
                  )
                : const SizedBox(),
            missionController.selectedMission.active
                ? TextButton.icon(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => DefaultActionDialog(
                          titleText: AppTexts.confirmation,
                          actionText: AppTexts.yes,
                          action: deactivateAction(
                            context: context,
                            missionController: missionController,
                            missionId: missionController.selectedMission.id,
                          ),
                          contentText: AppTexts.missionDeactivateConfirmation,
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.cancel_outlined,
                    ),
                    label: const Text(
                      AppTexts.deactivate,
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  )
                : const SizedBox()
          ],
          state: missionController.state,
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  '#${missionController.selectedMission.number.toStringLeadingZeroes()}',
                ),
                const Divider(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    top: 15,
                    bottom: 200,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const Text(
                        '${AppTexts.points}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        missionController.selectedMission.points
                            .toStringDecimal(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AppTexts.expirationDate}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${missionController.selectedMission.expirationDate.toLocalDateExtendedString()} ${AppTexts.at} ${missionController.selectedMission.expirationDate.toLocalTimeString()}h',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        '${AppTexts.description}:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        missionController.selectedMission.description,
                        textAlign: TextAlign.justify,
                      )
                    ],
                  ),
                ),
              ],
            ),
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
          if (result) {
            missionController.selectedMission.active = false;
          }
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
