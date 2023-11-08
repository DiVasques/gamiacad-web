import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';

class DefaultActionDialog extends StatelessWidget {
  final String titleText;
  final String actionText;
  final void Function()? action;
  final String? contentText;

  const DefaultActionDialog({
    super.key,
    required this.titleText,
    required this.actionText,
    this.action,
    this.contentText,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
        child: Text(
          titleText,
        ),
      ),
      content: contentText != null
          ? Text(
              '$contentText',
              style: const TextStyle(fontSize: 14),
              textAlign: TextAlign.center,
            )
          : null,
      actionsAlignment: MainAxisAlignment.spaceBetween,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.errorGray,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(AppTexts.cancel),
        ),
        TextButton(
          onPressed: action != null
              ? () {
                  action!();
                  Navigator.of(context).pop();
                }
              : null,
          child: Text(actionText),
        ),
      ],
    );
  }
}
