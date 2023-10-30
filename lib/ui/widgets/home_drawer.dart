import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/widgets/home_drawer_item.dart';
import 'package:gami_acad_web/ui/widgets/home_drawer_logout_item.dart';
import 'package:provider/provider.dart';

class HomeDrawer extends StatelessWidget {
  final int drawerSize = 56;
  final double drawerTextWidth = 200;
  final Duration animationDuration = const Duration(milliseconds: 100);
  final Curve animationCurve = Curves.fastOutSlowIn;
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeController>(builder: (context, homeController, _) {
      return Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeDrawerItem(
                drawerSize: drawerSize,
                drawerTextWidth: drawerTextWidth,
                animationDuration: animationDuration,
                animationCurve: animationCurve,
                icon: Icons.checklist_rounded,
                drawerTitle: AppTexts.missionList,
                viewState: SelectedViewState.mission,
              ),
              HomeDrawerItem(
                drawerSize: drawerSize,
                drawerTextWidth: drawerTextWidth,
                animationDuration: animationDuration,
                animationCurve: animationCurve,
                icon: Icons.shopping_basket_rounded,
                drawerTitle: AppTexts.rewardList,
                viewState: SelectedViewState.reward,
              ),
              Expanded(
                child: InkWell(
                  onTap: homeController.drawerTapFunction,
                  child: AnimatedContainer(
                    curve: animationCurve,
                    duration: animationDuration,
                    width: homeController.showOpenedDrawer
                        ? drawerTextWidth + 56
                        : 56,
                    color: AppColors.darkerPrimaryColor,
                  ),
                ),
              ),
              HomeDrawerLogoutItem(
                drawerSize: drawerSize,
                drawerTextWidth: drawerTextWidth,
                animationDuration: animationDuration,
                animationCurve: animationCurve,
              ),
            ],
          ),
          homeController.showOpenedDrawer
              ? Expanded(
                  child: GestureDetector(
                    onTap: homeController.drawerTapFunction,
                  ),
                )
              : Container(),
        ],
      );
    });
  }
}
