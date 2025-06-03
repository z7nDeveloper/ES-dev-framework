

import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/restrict_size_model.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/restricted_element_definition.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/restricted_size_profile.dart';
import 'package:flexible_structures/widgets/base_templates/framework.dart';
import 'package:flexible_structures/widgets/base_templates/global_context.dart';
import 'package:flexible_structures/widgets/base_templates/go_back_button.dart';
import 'package:flexible_structures/widgets/base_templates/template_background.dart';
import 'package:flexible_structures/widgets/base_templates/template_body.dart';
import 'package:flexible_structures/widgets/base_templates/template_defaults.dart';
import 'package:flutter/material.dart';


// #TODO REMEMBER: ENUM FOR SCROLL BEHAVIOUR
// #TODO REMEMBER: ENUM FOR BACKGROUND ORGANIZATION
// #TODO REMEMBER: BRING TEMPLATE ITEM CLASS FROM SMU PROJECT FILES
// #TODO REMEMBER: ENUM FOR NAVIGATION BEHAVIOUR

class NavbarConfiguration extends NavbarDefinition {
  Widget? restrictedSizeNavBar;
  Widget? background;
  Widget? appending;
  Widget? navbar;

  double? navbarHeight;
  EdgeInsets? padding;
  bool useDefaultPadding;
  bool? navigatorAsBackground;
  bool usesDefaultNavbar;
  bool useDefaultBackgroundPadding;
  bool useTwoNavbars; //
  bool ignoreNavbarPadding;

  MainAxisAlignment mainAlignment;

  bool canIgnoreNavbarHeight;


  NavbarConfiguration(
      {this.navbar,
        this.navbarHeight,
        this.restrictedSizeNavBar,
        this.background,
        this.appending,
        this.padding,
        this.usesDefaultNavbar = true,
        this.canIgnoreNavbarHeight = true,
        this.mainAlignment = MainAxisAlignment.start,
        this.useDefaultPadding = true,
        this.useTwoNavbars = false,

        this.ignoreNavbarPadding = true,
        this.useDefaultBackgroundPadding = true,
        this.navigatorAsBackground});

  @override
  double get height => navbarHeight ?? Framework.templateDefaults.navbar.height;

  bool get useNavigatorAsBackground => navigatorAsBackground
  ?? Framework.templateDefaults.navbar.useAsBackground;

  static NavbarConfiguration empty() {
    return NavbarConfiguration(
      navbarHeight: 0,
      usesDefaultNavbar: false,
      useDefaultPadding: false,
      useDefaultBackgroundPadding: false,

    );
  }
}

class AppbarConfiguration extends AppbarDefinition {
  final Widget? content;
  final Widget? background;
  final MainAxisAlignment? mainAlignment;

  final bool ignorePadding;
  final bool useDefault;
  dynamic navbarHeight;
  final bool? shouldRestrictWidth;

  AppbarConfiguration(
      {this.content,
        height,
        this.useDefault = true,
        this.background,
        this.mainAlignment,
        this.ignorePadding = false,
        this.shouldRestrictWidth}) {
    navbarHeight = height;
  }

  bool hasAppBar() {
    return useDefault || (background != null && content != null);
  }


  @override
  dynamic get height => navbarHeight ?? Framework.templateDefaults.appbar.height;

  @override
  bool get restrictWidth =>
      shouldRestrictWidth ?? Framework.templateDefaults.appbar.restrictWidth;

  static AppbarConfiguration empty() {
    return AppbarConfiguration(
        ignorePadding: true,
        useDefault: false,
        height: 0
    );
  }

  AppbarConfiguration overrideToEmpty() {
    return AppbarConfiguration.empty();
  }

  static AppbarConfiguration withTitle({
    required String title,
    bool withBackButton=true
  }) {

    return AppbarConfiguration(
        height: 100,
        content: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              withBackButton
                  ? Flexible(

                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GoBackButton(size: 30,),
                    ],
                  )) :
              withBackButton ? Container() :Spacer(),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              Spacer(),
            ],
          ),
        )
    );
  }
}

enum ScrollerBehaviour { whole, onlyBody, none }

class BodyConfiguration {}

class TemplateScaffold extends StatelessWidget {
  final Widget body;
  final List<Widget>? footer;
  final Widget? background;
  final Color? backgroundColor;
  late NavbarConfiguration navbarConfiguration;
  late AppbarConfiguration appbarConfiguration;

  final ScrollerBehaviour? scrollerBehaviour;
  final bool showRouteNavigator;
  final bool useDefaultPadding;
  final bool nullifyHeight;
  final bool isUsingScaffold;
  final bool useOverlay;

  final Widget Function(BuildContext context, double realWidth, Widget body)?
  bodyParent;
  final Widget? backgroundBeforeNavigation;
  final Widget? floatingAction;

  final bool? isUsingDrawer;

  static Color? defaultBackgroundColor;

  final bool restrictWidth;
  final Widget? leftSideBody;

  final RestrictedSizeProfile restrictedSizeProfile;

  TemplateScaffold(
      {Key? key,
        required this.body,
        this.backgroundBeforeNavigation,
        this.isUsingDrawer,
        this.useDefaultPadding = true,
        this.nullifyHeight = false,
        this.bodyParent,
        this.showRouteNavigator = true,
        this.floatingAction,
        this.background,
        this.footer,
        this.leftSideBody,
        NavbarConfiguration? navbarConfig,
        AppbarConfiguration? appbarConfig,
        this.isUsingScaffold = true,
        this.scrollerBehaviour,
        this.backgroundColor, this.restrictWidth=true,
        this.useOverlay = true,
        this.restrictedSizeProfile=RestrictedSizeProfile.base,})
      : super(key: key) {
    navbarConfiguration = navbarConfig ?? NavbarConfiguration();
    appbarConfiguration = appbarConfig ?? AppbarConfiguration();
  }

  static Widget empty({required Widget body}) {
    return TemplateScaffold(
        appbarConfig: AppbarConfiguration.empty(),
        navbarConfig: NavbarConfiguration.empty(),
        useDefaultPadding: false,
        restrictedSizeProfile: RestrictedSizeProfile.expanded,
        body: body
    );
  }

  @override
  Widget build(BuildContext context) {
    if (!isUsingScaffold) {
      return body;
    }

    GlobalContextService.context = context;

    double realWidth = MediaQuery.of(context).size.width;
    RestrictSizeModel sizeModel =   RestrictSizeModel(
        realSize: realWidth,
        restrictedSizeProfile: restrictedSizeProfile,
      profileOptions: {
          RestrictedSizeProfile.base: baseWidthLimits,
        RestrictedSizeProfile.expanded: expandedWidthLimits,
      }
    );

    double restrictedWidth = restrictWidth ? sizeModel.value() : realWidth;

    //restrictedWidth = max(restrictedWidth, 300);
    RestrictedElementDefinition elementDefinition = RestrictedElementDefinition(
        realWidth: realWidth,
        restrictedWidth: restrictedWidth,
        preferredHeight: appbarConfiguration.height);

    /*
    if (screenModelBasedOnWidth() == DeviceType.mobile &&
        !devMode &&
        usesMobileBlock) {
      return InProgress(templateScaffold: this);
    }*/


    Widget bodyWidget = _TemplateBody(
        navbarConfiguration: navbarConfiguration,
        elementDefinition: elementDefinition,
        background: background,
        appbarConfiguration: appbarConfiguration,
        scrollerBehaviour: scrollerBehaviour,
        body: body,
        useDefaultPadding: useDefaultPadding,
        bodyParent: bodyParent);

    if(Framework.templateDefaults.body.bodyWrapper != null) {
      bodyWidget = Framework.templateDefaults.body.bodyWrapper!(context, bodyWidget);
    }

    // screenshotTaker.wrapWithScreenshot
    return Scaffold(
      bottomNavigationBar: footer == null ? null : Container(

        child: Column(
          mainAxisSize: MainAxisSize.min,
         // crossAxisAlignment: CrossAxisAlignment.end,
         // mainAxisAlignment: MainAxisAlignment.end,
          children: footer!,
        ),
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingAction ?? (
          Framework.templateDefaults.defaultFloatingActions == null ? null :
          Framework.templateDefaults.defaultFloatingActions!(context)

      ),
      backgroundColor: backgroundColor ?? defaultBackgroundColor ??
          Theme.of(context).scaffoldBackgroundColor
          ,
      body:
      ( Framework.templateDefaults.body.overlay == null &&
      leftSideBody == null)

          ? bodyWidget :
      Stack(
        children: [
          bodyWidget,
          Framework.templateDefaults.body.overlay == null
              ? Container()
              : Framework.templateDefaults.body.overlay!(OverlayConfiguration(
              context: context, useOverlay: useOverlay)),
          leftSideBody ?? Container(),
        ],
      ),
      appBar: appbarConfiguration.hasAppBar()
          ? elementDefinition.getElement(
          width: Framework.templateDefaults.appbar.restrictWidth
              ? null
              : MediaQuery.of(context).size.width,
          content: appbarConfiguration.content ??
              (appbarConfiguration.useDefault
                  ? Framework.templateDefaults.appbar.content
                  : null),
          background: appbarConfiguration.background ??
              (appbarConfiguration.useDefault
                  ? Framework.templateDefaults.appbar.background
                  : null))
          : null,
      drawer: usesDrawer ? Framework.templateDefaults.drawer : null,
    );
  }

  bool get usesDrawer => isUsingDrawer ?? Framework.templateDefaults.usesDrawer;
}

class _TemplateBody extends StatelessWidget {
  const _TemplateBody({
    super.key,
    required this.navbarConfiguration,
    required this.elementDefinition,
    required this.background,
    required this.appbarConfiguration,
    required this.scrollerBehaviour,
    required this.body,
    required this.useDefaultPadding,
    required this.bodyParent,
  });

  final NavbarConfiguration navbarConfiguration;
  final RestrictedElementDefinition elementDefinition;
  final Widget? background;
  final AppbarConfiguration appbarConfiguration;
  final ScrollerBehaviour? scrollerBehaviour;
  final Widget body;
  final bool useDefaultPadding;

  final Widget Function(BuildContext context, double realWidth, Widget body)?
  bodyParent;

  @override
  Widget build(BuildContext context) {

    MediaQuery.of(context).size;
    return TemplateBodyLayout(
      definition: BodyLayoutDefinition(
        background: TemplateBackgroundLayout(
          definition: BackgroundLayoutDefinition(
              navbarConfiguration: navbarConfiguration,
              elementDefinition: elementDefinition,
              background: background),
        ),
        appbarConfiguration: appbarConfiguration,
        navbarConfiguration: navbarConfiguration,
        scrollBehaviour:
        scrollerBehaviour ?? Framework.templateDefaults.scrollerBehaviour,
        elementDefinition: elementDefinition,
        body: body,
        useDefaultPadding: useDefaultPadding,
        bodyParent: bodyParent,

      ),
    );
  }
}

class TemplateTopNavbarContent extends StatelessWidget {
  final double height;
  final NavbarConfiguration navbarConfiguration;

  const TemplateTopNavbarContent({
    Key? key,
    required this.height,
    required this.navbarConfiguration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: navbarConfiguration.padding ?? EdgeInsets.zero,
      child: SizedBox(
        height: height,
        child: Padding(
          padding: const EdgeInsets.only(top: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: navbarConfiguration.mainAlignment,
            children: [
              navbarConfiguration.navbar ?? Container(),
              navbarConfiguration.appending ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}


