

import 'package:flexible_structures/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import './bloc/login_form_bloc.dart';
import './data/mock_login_interactor.dart';
import './view/login_page.dart';
import 'package:go_router/go_router.dart';





// current behaviour is a solution for not using go_router temporarily


class LoginRoute extends AppRoute {

  LoginRoute( );

  Widget getPage(BuildContext context, GoRouterState state) {
    return LoginPage(
        loginFormBloc: LoginFormBloc(loginFormInteractor: MockLoginInteractor()),
        loginNavigator: GetIt.I.get<LoginNavigator>(),
    );
  }

  // define a configuração da rota
  @override
  GoRoute getRoute() {
    return GoRoute(path: routePath,
        builder: getPage);
  }

  @override
  String get routePath => "/login";
}

abstract class LoginNavigator {
  navigateAfterLogin(BuildContext context);
}

