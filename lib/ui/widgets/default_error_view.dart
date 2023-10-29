import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';

class DefaultErrorView extends StatelessWidget {
  final String message;
  final void Function()? onPressed;

  const DefaultErrorView({
    this.message = '',
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '${AppTexts.error}:',
            style: TextStyle(
              color: AppColors.errorGray,
              fontSize: 20,
            ),
          ),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.errorGray,
              fontSize: 20,
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.replay_outlined,
              // size: 30,
            ),
            onPressed: onPressed,
            color: AppColors.errorGray,
          ),
        ],
      ),
    );
  }
}
