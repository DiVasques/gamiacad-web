import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/user_management_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/extensions/date_extension.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:gami_acad_web/ui/views/base_section_view.dart';
import 'package:gami_acad_web/ui/widgets/default_action_dialog.dart';
import 'package:gami_acad_web/ui/widgets/default_error_view.dart';
import 'package:gami_acad_web/ui/widgets/user_management_table_headers.dart';
import 'package:provider/provider.dart';

class UserManagementListView extends StatelessWidget {
  static const EdgeInsets _tableRowPadding =
      EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 5);
  const UserManagementListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserManagementController>(
      builder: (context, userManagementController, _) {
        return BaseSectionView(
          viewTitle: AppTexts.userManagement,
          reloadAction: userManagementController.getUsers,
          state: userManagementController.state,
          errorBody: DefaultErrorView(
            message: userManagementController.errorMessage,
            onPressed: userManagementController.getUsers,
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
                  1: IntrinsicColumnWidth(),
                  2: IntrinsicColumnWidth(),
                  3: IntrinsicColumnWidth(),
                },
                defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
                border: TableBorder.symmetric(
                  inside: const BorderSide(
                    width: 1,
                    color: Colors.black12,
                  ),
                ),
                children: userManagementController.state != ViewState.idle
                    ? []
                    : [
                        UserManagementTableHeaders.build(),
                        ...userManagementController.users
                            .map(
                              (user) => TableRow(
                                children: [
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      user.name,
                                      maxLines: 2,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      user.registration,
                                    ),
                                  ),
                                  Padding(
                                    padding: _tableRowPadding,
                                    child: Text(
                                      user.createdAt.toLocalDateString(),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: IconButton(
                                      icon: Icon(
                                        user.admin
                                            ? Icons.check_box_rounded
                                            : Icons
                                                .check_box_outline_blank_rounded,
                                      ),
                                      tooltip: user.admin
                                          ? AppTexts.userRevokePrivilege
                                          : AppTexts.userGivePrivilege,
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              DefaultActionDialog(
                                            titleText: AppTexts.confirmation,
                                            actionText: AppTexts.yes,
                                            action: updateUserPrivilegesAction(
                                              context: context,
                                              userManagementController:
                                                  userManagementController,
                                              userId: user.id,
                                              admin: !user.admin,
                                            ),
                                            contentText: AppTexts
                                                .userManagementUpdatePrivilegesConfirmation,
                                          ),
                                        );
                                      },
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

  void Function() updateUserPrivilegesAction({
    required BuildContext context,
    required UserManagementController userManagementController,
    required String userId,
    required bool admin,
  }) {
    return () {
      userManagementController
          .updateUserPrivileges(userId: userId, admin: admin)
          .then(
        (result) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              duration: const Duration(seconds: 2),
              content: Text(
                result
                    ? AppTexts.userManagementUpdatePrivilegesSuccess
                    : AppTexts.userManagementUpdatePrivilegesError,
              ),
            ),
          );
          userManagementController.getUsers();
        },
      );
    };
  }
}
