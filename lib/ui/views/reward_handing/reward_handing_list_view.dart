import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/reward_handing_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/reward_handing_table_headers.dart';
import 'package:gami_acad_web/ui/widgets/default_error_view.dart';
import 'package:provider/provider.dart';

class RewardHandingListView extends StatelessWidget {
  static const EdgeInsets _tableRowPadding =
      EdgeInsets.only(top: 10, left: 15, right: 15);
  const RewardHandingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<RewardHandingController>(
      builder: (context, rewardHandingController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.rewardHanding,
          reloadAction: rewardHandingController.getClaimedRewards,
          state: rewardHandingController.state,
          errorBody: DefaultErrorView(
            message: rewardHandingController.errorMessage,
            onPressed: rewardHandingController.getClaimedRewards,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(30),
            child: Container(
              decoration: BoxDecoration(
                border:
                    Border.all(width: 2, color: AppColors.darkerPrimaryColor),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Table(
                columnWidths: const {
                  0: IntrinsicColumnWidth(),
                  3: IntrinsicColumnWidth(),
                  4: IntrinsicColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                border: TableBorder.symmetric(
                  inside: const BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
                children: rewardHandingController.state != ViewState.idle
                    ? []
                    : [
                        RewardHandingTableHeaders.build(),
                        ...rewardHandingController.claimedRewards
                            .map(
                              (reward) => TableRow(
                                children: [
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      reward.number.toString(),
                                      maxLines: 2,
                                      textAlign: TextAlign.end,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      reward.name,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      reward.claimer.name,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      reward.claimer.registration,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      reward.claimDate.toLocalDateTimeString(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ],
              ),
            ),
          ),
        );
      },
    );
  }
}
