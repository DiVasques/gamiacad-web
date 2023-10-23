import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/widgets/login_forms.dart';

class SmallLoginScreen extends StatelessWidget {
  const SmallLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primaryColor,
      ),
      child: const SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 150,
            ),
            Text(
              AppTexts.gamiAcadLongTitle,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            LoginForms(showLogo: true),
          ],
        ),
      ),
    );
  }
}
