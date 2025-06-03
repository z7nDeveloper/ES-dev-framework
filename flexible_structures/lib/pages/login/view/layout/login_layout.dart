


import 'package:flexible_structures/pages/login/bloc/login_form_bloc.dart';
import 'package:flexible_structures/pages/login/view/widgets/test_demo_button.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/display/background_card.dart';
import 'package:flexible_structures/widgets/graphical_item/app_logo.dart';
import 'package:flexible_structures/widgets/interactions/input_spacer.dart';
import 'package:flexible_structures/widgets/layout/template_flex_screen.dart';
import 'package:flexible_structures/widgets/theme_related/app_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/auth_buttons.dart';
import '../widgets/forgot_password.dart';
import '../widgets/login_confirm_button.dart';
import '../widgets/login_form.dart';


class LoginLayoutConstruction {
  final LoginState state; 
  final Function() onLogin;
  LoginLayoutConstruction({ 
    required this.state,
    required this.onLogin,
});
}



class DefaultLoginLayout extends StatelessWidget {

  final LoginLayoutConstruction construction;
  const DefaultLoginLayout({super.key,
    required this.construction,
  });

  @override
  Widget build(BuildContext context) {



    return TemplateFlexScreen(

      structure: TemplateFlexStructure(
        structureFlex: [1,12,1],
        bodyLeft: AppContainer(
          color: Colors.red,
          child: Column(
            children: [

              Expanded(
                  flex: 3,
                  child: AppLogo()
              ),
              Spacer(),
              Flexible(
                  flex: 4,
                  child: Container(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: 480
                      ),
                      child: BackgroundCard(
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Flexible(
                                  flex:2,
                                  child: LoginForm(
                                    appending: ForgotPassword(),
                                  )),
                              InputSpacer(),
                              LoginConfirmButton(
                                callLogin:
                                (construction.state is LoginFailure) ?
                                null :
                                construction.onLogin
                                ,
                              ),

                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
              ),
              AuthButtons(),

              Flexible(child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 480
                  ),
                  child: TestDemoButton()))

            ],
          ),
        )
      ),

    );




  }
}
