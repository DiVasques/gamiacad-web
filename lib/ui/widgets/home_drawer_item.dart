import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:provider/provider.dart';

class HomeDrawerItem extends StatelessWidget {
  final int drawerSize;
  final double drawerTextWidth;
  final Duration animationDuration;
  final Curve animationCurve;
  final IconData icon;
  final String drawerTitle;
  final SelectedViewState viewState;
  const HomeDrawerItem({
    super.key,
    required this.drawerSize,
    required this.drawerTextWidth,
    required this.animationDuration,
    required this.animationCurve,
    required this.icon,
    required this.drawerTitle,
    required this.viewState,
  });

  @override
  Widget build(BuildContext context) {
    Color getColor(SelectedViewState selectedView) {
      if (viewState == selectedView) {
        return AppColors.lighterPrimaryColor;
      }
      return AppColors.darkerPrimaryColor;
    }

    return Consumer<HomeController>(
      builder: (context, homeController, _) {
        return Row(
          children: <Widget>[
            InkWell(
              onTap: () {
                homeController.selectedView = viewState;
                if (homeController.showOpenedDrawer) {
                  homeController.drawerTapFunction();
                }
              },
              child: Container(
                width: 56,
                height: 56,
                color: getColor(homeController.selectedView),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                homeController.selectedView = viewState;
                if (homeController.showOpenedDrawer) {
                  homeController.drawerTapFunction();
                }
              },
              child: AnimatedContainer(
                curve: animationCurve,
                alignment: Alignment.center,
                duration: animationDuration,
                width: homeController.showOpenedDrawer ? drawerTextWidth : 0,
                height: 56,
                color: getColor(homeController.selectedView),
                onEnd: () {
                  homeController.showDrawerText = true;
                },
                child: homeController.showOpenedDrawer
                    ? Text(
                        homeController.showDrawerText ? drawerTitle : '',
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
