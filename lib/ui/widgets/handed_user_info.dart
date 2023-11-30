import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:provider/provider.dart';

class HandedUserInfo extends StatelessWidget {
  final double maxViewItemsWidth;
  const HandedUserInfo({super.key, required this.maxViewItemsWidth});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardController>(
      builder: (context, rewardController, _) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxWidth: maxViewItemsWidth),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              rewardController.selectedReward.handedInfo.isNotEmpty
                  ? const Text(
                      '${AppTexts.handedList}:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : const SizedBox(),
              rewardController.selectedReward.handedInfo.isNotEmpty
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
                        ...rewardController.selectedReward.handedInfo
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
