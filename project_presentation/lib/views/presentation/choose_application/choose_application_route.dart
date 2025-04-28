import 'package:flexible_structures/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


import 'choose_application_page.dart';

class ChooseApplicationRoute extends AppRoute {

  final List<Map<String, dynamic>>? entranceActions;
  final Function(BuildContext context)? appbarElement;

  ChooseApplicationRoute({this.entranceActions,
  this.appbarElement,
  });

  // calls route page once, to add to the widget
  GoRoute getRoute() {
    return GoRoute(
      path: routePath,
      builder: getPage,
    );
  }

  Widget getPage(BuildContext context, GoRouterState state) {
    return ChooseApplicationPage(
      entranceActions: entranceActions ?? [],
        appbarElement: appbarElement,
    );
  }


  String get routePath => "/";
}