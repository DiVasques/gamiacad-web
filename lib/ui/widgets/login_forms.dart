import 'package:flutter/material.dart';
import 'package:gami_acad_web/ui/controllers/login_controller.dart';
import 'package:gami_acad_web/ui/widgets/login_button.dart';
import 'package:gami_acad_web/ui/widgets/login_inputs.dart';
import 'package:provider/provider.dart';

class LoginForms extends StatefulWidget {
  final bool showLogo;
  const LoginForms({super.key, this.showLogo = false});

  @override
  State<LoginForms> createState() => _LoginFormsState();
}

class _LoginFormsState extends State<LoginForms> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginController>(
      builder: (BuildContext context, LoginController loginController, _) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.only(
                      top: 10, left: 10, right: 10, bottom: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 375,
                  child: Column(
                    children: <Widget>[
                      ...buildLogo(widget.showLogo),
                      LoginInputs(formKey: _formKey),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            LoginButton(formKey: _formKey),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  List<Widget> buildLogo(bool showLogo) {
    if (showLogo) {
      return [
        const Center(
          child: Image(
            image: AssetImage('assets/images/logo_del.png'),
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(
          height: 25,
        )
      ];
    }
    return [];
  }
}
