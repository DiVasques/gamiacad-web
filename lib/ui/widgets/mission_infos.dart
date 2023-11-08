import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/mission_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/extensions/int_extension.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class MissionInfos extends StatelessWidget {
  final double maxViewItemsWidth;
  const MissionInfos({super.key, required this.maxViewItemsWidth});

  @override
  Widget build(BuildContext context) {
    return Consumer<MissionController>(
      builder: (context, missionController, _) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxViewItemsWidth),
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
              const Gap(5),
              Text(
                missionController.selectedMission.points.toStringDecimal(),
              ),
              const Gap(10),
              const Text(
                '${AppTexts.expirationDate}:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                '${missionController.selectedMission.expirationDate.toLocalDateExtendedString()} ${AppTexts.at} ${missionController.selectedMission.expirationDate.toLocalTimeString()}h',
              ),
              const Gap(10),
              const Text(
                '${AppTexts.createdBy}:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                missionController.selectedMission.createdByInfo.name,
              ),
              const Gap(10),
              const Text(
                '${AppTexts.description}:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Gap(5),
              Text(
                missionController.selectedMission.description,
                textAlign: TextAlign.justify,
              ),
              const Gap(10),
              missionController.selectedMission.completersInfo.isNotEmpty
                  ? const Text(
                      '${AppTexts.completersList}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              missionController.selectedMission.completersInfo.isNotEmpty
                  ? Table(
                      columnWidths: const {1: IntrinsicColumnWidth()},
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.bottom,
                      border: TableBorder.symmetric(
                        inside:
                            const BorderSide(width: 1, color: Colors.black12),
                      ),
                      children: [
                        const TableRow(
                          children: [
                            Text(
                              AppTexts.name,
                              maxLines: 2,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                AppTexts.registration,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        ...missionController.selectedMission.completersInfo
                            .map(
                              (user) => TableRow(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 10),
                                    child: Text(
                                      user.name,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      left: 15,
                                      top: 10,
                                    ),
                                    child: Text(
                                      user.registration,
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}
