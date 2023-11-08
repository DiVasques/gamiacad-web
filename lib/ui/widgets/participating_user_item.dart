import 'package:flutter/material.dart';
import 'package:gami_acad_web/repository/models/user.dart';
import 'package:gami_acad_web/ui/controllers/participating_users_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class ParticipatingUserItem extends StatefulWidget {
  final User user;
  const ParticipatingUserItem({
    super.key,
    required this.user,
  });

  @override
  State<ParticipatingUserItem> createState() => _ParticipatingUserItemState();
}

class _ParticipatingUserItemState extends State<ParticipatingUserItem> {
  late bool selected;

  @override
  void initState() {
    selected = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ParticipatingUsersController>(
      builder: (context, participatingUsersController, _) {
        return Container(
          margin: const EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(5),
          ),
          child: InkWell(
            onTap: () => {
              setState(() {
                selected = !selected;
                if (selected) {
                  participatingUsersController.addSelectedUser(widget.user);
                  return;
                }
                if (!selected) {
                  participatingUsersController.removeSelectedUser(widget.user);
                  return;
                }
              })
            },
            child: Padding(
              padding: const EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Text(widget.user.name)),
                      const Gap(2),
                      Text.rich(
                        TextSpan(
                          children: <TextSpan>[
                            const TextSpan(
                              text: '${AppTexts.registration}: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: widget.user.registration,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Icon(
                    selected
                        ? Icons.check_box_rounded
                        : Icons.check_box_outline_blank_rounded,
                    color: AppColors.primaryColor,
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
