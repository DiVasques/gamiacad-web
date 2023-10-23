import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/widgets/login_forms.dart';

class LargeLoginScreen extends StatelessWidget {
  const LargeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              height: screenWidth >= 1920 ? null : 150,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(left: 50, right: 25),
              child: const Image(
                image: AssetImage('assets/images/logo_del.png'),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: Container(
                height: screenHeight > 400 ? null : 400,
                alignment: Alignment.centerRight,
                decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black38,
                      offset: Offset(-5, 0),
                      blurRadius: 10,
                    )
                  ],
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(5000),
                  ),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 60, vertical: 20),
                      child: Text(
                        AppTexts.gamiAcadLongTitle,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        LoginForms(),
                        SizedBox(
                          width: 50,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
