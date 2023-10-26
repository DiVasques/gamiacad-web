import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/login_controller.dart';
import 'package:gami_acad_web/ui/routers/generic_router.dart';
import 'package:gami_acad_web/ui/utils/app_texts.dart';
import 'package:gami_acad_web/ui/widgets/default_text_field.dart';
import 'package:provider/provider.dart';

class LoginInputs extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  const LoginInputs({super.key, required this.formKey});

  @override
  State<LoginInputs> createState() => _LoginInputsState();
}

class _LoginInputsState extends State<LoginInputs> {
  static const TextStyle style = TextStyle(fontSize: 20.0);
  late FocusNode _registrationFocus;
  late FocusNode _passwordFocus;

  @override
  void initState() {
    _registrationFocus = FocusNode();
    _passwordFocus = FocusNode();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (BuildContext context, LoginController loginController, _) {
        String? validateRegistration(String? input) {
          input!.trim();
          RegExp validRegistrationPattern = RegExp(r'^[0-9]{11}$');
          if (!validRegistrationPattern.hasMatch(input)) {
            return AppTexts.invalidRegistration;
          }
          return null;
        }

        String? validatePwd(String? input) {
          int pwdLength = input!.length;
          if (pwdLength < 12) {
            return AppTexts.invalidPassword;
          }
          if (loginController.loginError) {
            return loginController.errorMessage;
          }
          return null;
        }

        return Column(
          children: [
            DefaultTextField(
              initValue: '12345678909',
              validator: validateRegistration,
              labelText: AppTexts.registration,
              style: style,
              keyboardType: TextInputType.emailAddress,
              onSaved: (value) => loginController.registration = value,
              focusNode: _registrationFocus,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
                FocusScope.of(context).requestFocus(_passwordFocus);
              },
            ),
            const SizedBox(
              height: 20,
            ),
            DefaultTextField(
              initValue: 'V!12341234123',
              validator: validatePwd,
              labelText: AppTexts.password,
              style: style,
              obscureText: true,
              keyboardType: TextInputType.text,
              onSaved: (value) => loginController.password = value,
              focusNode: _passwordFocus,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) async {
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
                        arguments: loginController.userAccess.id,
                      );
                      return;
                    }
                    _validateAndSaveFields();
                  },
                );
              },
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        );
      },
    );
  }

  bool _validateAndSaveFields() {
    final formState = widget.formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      return true;
    } else {
      return false;
    }
  }
}
