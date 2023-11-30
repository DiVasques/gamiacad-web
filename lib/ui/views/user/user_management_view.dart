import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/user_management_controller.dart';
import 'package:gami_acad_web/ui/views/user/user_management_list_view.dart';
import 'package:provider/provider.dart';

class UserManagementView extends StatelessWidget {
  final String userId;
  const UserManagementView({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserManagementController(userId: userId),
      child: Consumer<UserManagementController>(
        builder: (context, userManagementController, _) {
          return const UserManagementListView();
        },
      ),
    );
  }
}
