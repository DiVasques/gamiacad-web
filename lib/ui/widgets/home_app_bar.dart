import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/home_controller.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:provider/provider.dart';

class HomeAppBar extends AppBar {
  HomeAppBar({super.key})
      : super(
          title: const Text(AppTexts.gamiAcadLongTitle),
          leading: Consumer<HomeController>(
            builder: (context, homeController, _) {
              return InkWell(
                onTap: homeController.drawerTapFunction,
                child: const Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: Icon(Icons.menu),
                  ),
                ),
              );
            },
          ),
        );
}
