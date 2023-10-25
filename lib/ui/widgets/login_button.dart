import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/login_controller.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:gami_acad_web/ui/utils/app_colors.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/utils/view_state.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  const LoginButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (BuildContext context, LoginController loginController, _) {
        return SizedBox(
          height: 45,
          child: MaterialButton(
            color: AppColors.primaryColor,
            animationDuration: const Duration(milliseconds: 600),
            onPressed: loginController.state == ViewState.idle
                ? () async {
                    loginController.loginError = false;
                    if (!_validateAndSaveFields()) {
                      return;
                    }
                    loginController.handleSignIn().then(
                      (result) {
                        if (result.status) {
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            GenericRouter.homeRoute,
                            (Route<dynamic> route) => false,
                          );
                          return;
                        }
                        _validateAndSaveFields();
                      },
                    );
                  }
                : () {},
            shape: const StadiumBorder(),
            child: Padding(
              padding: EdgeInsets.all(
                  loginController.state == ViewState.idle ? 10 : 0),
              child: loginController.state == ViewState.idle
                  ? const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.face,
                          color: AppColors.lighterPrimaryColor,
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Text(
                          AppTexts.login,
                          maxLines: 1,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    )
                  : const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
            ),
          ),
        );
      },
    );
  }

  bool _validateAndSaveFields() {
    final formState = formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      return true;
    } else {
      return false;
    }
  }
}
