import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/controllers/participating_users_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/widgets/participating_users_card.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ParticipatingUsersInfo extends StatelessWidget {
  final double maxViewItemsWidth;
  const ParticipatingUsersInfo({super.key, required this.maxViewItemsWidth});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ParticipatingUsersController(),
      child: Consumer2<MissionController, ParticipatingUsersController>(
        builder: (context, missionController, participatingUsersController, _) {
          return ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxViewItemsWidth),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Text(
                  '${AppTexts.participatingList}:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Gap(5),
                const ParticipatingUsersCard(),
                const Gap(10),
                TextButton(
                  onPressed: participatingUsersController
                              .selectedUsers.isNotEmpty &&
                          participatingUsersController.state != ViewState.busy
                      ? () {
                          completeMissionAction(
                            context: context,
                            missionController: missionController,
                            participatingUsersController:
                                participatingUsersController,
                            missionId: missionController.selectedMission.id,
                          );
                        }
                      : null,
                  child: const Text(AppTexts.complete),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  completeMissionAction({
    required BuildContext context,
    required MissionController missionController,
    required ParticipatingUsersController participatingUsersController,
    required String missionId,
  }) {
    participatingUsersController
        .completeMission(
      missionId: missionId,
      users: participatingUsersController.selectedUsers,
    )
        .then(
      (result) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 2),
            content: Text(
              result
                  ? AppTexts.missionCompleteSuccess
                  : AppTexts.missionCompleteError,
            ),
          ),
        );
        missionController.refreshMissionData(
          missionId: missionId,
          viewState: MissionViewState.details,
        );
      },
    );
  }
}
