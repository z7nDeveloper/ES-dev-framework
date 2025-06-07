




import 'package:common_extensions/extensions/vbr/bloc_extension.dart';
import 'package:flexible_structures/pages/login/bloc/login_form_bloc.dart' show LoginFormBloc;
import 'package:flexible_structures/pages/login/login_navigator.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'login_body.dart';

 
class LoginPage extends StatelessWidget {


  final LoginFormBloc loginFormBloc;
  final LoginNavigator loginNavigator;
  const LoginPage({super.key, required this.loginFormBloc,
  required this.loginNavigator,});

  @override
  Widget build(BuildContext context) {


    return TemplateScaffold.empty(
      body:
      MultiBlocProvider(providers: [
        createProvider(loginFormBloc),
      ],
        child: Provider(
            create: (BuildContext context) {
              return loginNavigator;
            },
            child: LoginBody(
            )),
      )
    );
  }
}
