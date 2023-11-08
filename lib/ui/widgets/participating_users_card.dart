import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/controllers/participating_users_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/widgets/participating_user_item.dart';
import 'package:provider/provider.dart';

class ParticipatingUsersCard extends StatelessWidget {
  const ParticipatingUsersCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer2<MissionController, ParticipatingUsersController>(
      builder: (context, missionController, participatingUsersController, _) {
        return Flexible(
          child: Container(
            width: double.infinity,
            height: 600,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.darkerPrimaryColor,
              ),
            ),
            child: participatingUsersController.state == ViewState.busy
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          missionController.selectedMission.participantsInfo
                              .map(
                                (participant) => ParticipatingUserItem(
                                  user: participant,
                                ),
                              )
                              .toList(),
                    ),
                  ),
          ),
        );
      },
    );
  }
}
