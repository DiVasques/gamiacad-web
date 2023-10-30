import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:provider/provider.dart';

class HomeDrawerLogoutItem extends StatelessWidget {
  final int drawerSize;
  final double drawerTextWidth;
  final Duration animationDuration;
  final Curve animationCurve;
  const HomeDrawerLogoutItem({
    super.key,
    required this.drawerSize,
    required this.drawerTextWidth,
    required this.animationDuration,
    required this.animationCurve,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                homeController.logoutUser();
                if (homeController.showOpenedDrawer) {
                  homeController.drawerTapFunction();
                }
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  GenericRouter.loginRoute,
                  (Route<dynamic> route) => false,
                );
              },
              child: Container(
                width: 56,
                height: 56,
                color: AppColors.darkerPrimaryColor,
                child: const Icon(
                  Icons.exit_to_app_rounded,
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                homeController.logoutUser();
                if (homeController.showOpenedDrawer) {
                  homeController.drawerTapFunction();
                }
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  GenericRouter.loginRoute,
                  (Route<dynamic> route) => false,
                );
              },
              child: AnimatedContainer(
                curve: animationCurve,
                alignment: Alignment.center,
                duration: animationDuration,
                width: homeController.showOpenedDrawer ? drawerTextWidth : 0,
                height: 56,
                color: AppColors.darkerPrimaryColor,
                onEnd: () {
                  homeController.showDrawerText = true;
                },
                child: homeController.showOpenedDrawer
                    ? Text(
                        homeController.showDrawerText ? AppTexts.logout : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : null,
              ),
            ),
          ],
        );
      },
    );
  }
}
