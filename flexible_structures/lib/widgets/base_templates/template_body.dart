


import 'dart:math';

import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/responsive/size_restriction_definition/restricted_element_definition.dart';
import 'package:flexible_structures/widgets/base_templates/framework.dart';
import 'package:flexible_structures/widgets/listing/multi_child_scroll_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';


class BodyLayoutDefinition {
  final Widget background;
  final NavbarConfiguration navbarConfiguration;
  final AppbarConfiguration appbarConfiguration;
  final RestrictedElementDefinition elementDefinition;
  final ScrollerBehaviour scrollBehaviour;

  final Widget body;
  final bool useDefaultPadding;
  final Widget Function(BuildContext context, double realWidth, Widget body)?
  bodyParent;
  BodyLayoutDefinition({
    required this.background,
    required this.appbarConfiguration,
    required this.scrollBehaviour,
    required this.navbarConfiguration,
    required this.elementDefinition,
    required this.body,
    required this.useDefaultPadding,
    required this.bodyParent,
  });
}

class TemplateBodyLayout extends StatefulWidget {
  final BodyLayoutDefinition definition;

  const TemplateBodyLayout({
    required this.definition,
    Key? key,
  }) : super(key: key);

  @override
  State<TemplateBodyLayout> createState() => _TemplateBodyLayoutState();
}

class _TemplateBodyLayoutState extends State<TemplateBodyLayout> {
  @override
  void initState() {
    super.initState();
  }

  /*
  double getBodyHeight(navbarSize) {
    double bodyHeight = MediaQuery.of(context).size.height -
        (widget.definition.appbarConfiguration.ignorePadding
            ? 0
            : Framework.templateDefaults.appbar.height ?? 0);

    bodyHeight -= 27;
    if(!widget.definition.navbarConfiguration.useNavigatorAsBackground) {
      bodyHeight -= navbarSize;
    }



    if (widget.definition.navbarConfiguration.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.navbar.padding;
    }

    /*if (widget.definition.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.body.topPadding;
    }*/

    return bodyHeight;
  }*/

  double getBodyHeight(navbarPadding) {
    double bodyHeight = MediaQuery.of(context).size.height -
        (widget.definition.appbarConfiguration.ignorePadding
            ? 0
            : Framework.templateDefaults.appbar.height ?? 0);

    if (!widget.definition.navbarConfiguration.ignoreNavbarPadding) {
      bodyHeight -= navbarPadding;
    }

    if (widget.definition.navbarConfiguration.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.navbar.padding;
    }

    if (widget.definition.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.body.topPadding;
    }



    return bodyHeight;
  }


  @override
  Widget build(BuildContext context) {
    Widget body = widget.definition.body;

    // #TODO  WHEN USING PATIENT HEADER, SPACE IN MOBILE OVERFLOWS

    EdgeInsets bodyPadding = widget.definition.useDefaultPadding
        ? EdgeInsets.only(top: Framework.templateDefaults.body.topPadding)
        : EdgeInsets.zero;

    double navbarPadding =
    (widget.definition.navbarConfiguration.ignoreNavbarPadding
        ? 0
        : widget.definition.navbarConfiguration.height);

    if (widget.definition.navbarConfiguration.useTwoNavbars) {
      double extraNavbarPadding = widget.definition.navbarConfiguration.height;
      navbarPadding += extraNavbarPadding;
    }

    bodyPadding = bodyPadding.copyWith(
        left: Framework.templateDefaults.body.horizontalPadding,
        right: Framework.templateDefaults.body.horizontalPadding,
        top: bodyPadding.top + navbarPadding);

    //bodyPadding = EdgeInsets.zero;
    double bodyHeight = getBodyHeight(navbarPadding);

    if((!widget.definition.navbarConfiguration.useNavigatorAsBackground)){
      bodyHeight -= widget.definition.navbarConfiguration.height;
          }
    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      body = Container(
        child: MultiChildScrollView(
            doubleDirection: screenModelBasedOnWidth() == DeviceType.mobile,
            scrollWidth: widget.definition.elementDefinition.realWidth,
            scrollHeight: bodyHeight,
            children: [
              body, /*
              Padding(
                padding: EdgeInsets.only(
                    top: widget.parent.navbarConfiguration.useTwoNavbars
                        ? 12
                        : 0),
                child: body,
              )*/
            ]),
      );
    }


    List<Widget> mainElements = [
      (!widget.definition.navbarConfiguration.useNavigatorAsBackground) ?
      TemplateTopNavbarContent(
        navbarConfiguration: NavbarConfiguration(
          padding: widget.definition.navbarConfiguration.useDefaultPadding
              ?Framework.templateDefaults.navbar.getPadding()
              : EdgeInsets.zero,
          appending: widget.definition.navbarConfiguration.appending,
          navbar: widget.definition.navbarConfiguration.navbar ??
              (widget.definition.navbarConfiguration.usesDefaultNavbar
                  ? Framework.templateDefaults.navbar.content
                  : null),
        ),
        height: widget.definition.navbarConfiguration.height,
      ) : Container(),
      widget.definition.elementDefinition.getElement(
          restrictedHeight: max(bodyHeight, 400),
          content: Column(
            children: [
              Container(
                child: Padding(
                  padding: bodyPadding,
                  child: Container(
                    //color: Colors.blue,

                      child: body),
                ),
              )
            ],
          ),
          parentBody: widget.definition.bodyParent,
          background: widget.definition.background)
    ];

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      return SizedBox(
          width: widget.definition.elementDefinition.realWidth,
          // height: widget.parent.nullifyHeight ? null : bodyHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainElements,
          ));
    }


    if (widget.definition.scrollBehaviour == ScrollerBehaviour.none) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: mainElements,
      );
    }

    return MultiChildScrollView(
        doubleDirection: true,
        scrollWidth: widget.definition.elementDefinition.realWidth,
        scrollHeight: bodyHeight,
        children: mainElements);
  }
/*
  @override
  Widget build(BuildContext context) {

    MediaQuery.of(context).size;
    Widget body = widget.definition.body;

    // #TODO  WHEN USING PATIENT HEADER, SPACE IN MOBILE OVERFLOWS

    EdgeInsets bodyPadding = widget.definition.useDefaultPadding
        ? EdgeInsets.only(top: Framework.templateDefaults.body.topPadding)
        : EdgeInsets.zero;

    double navbarSize =
        (widget.definition.navbarConfiguration.height);

    if (widget.definition.navbarConfiguration.useTwoNavbars) {
      double extraNavbarPadding = widget.definition.navbarConfiguration.height;
      navbarSize += extraNavbarPadding;
    }

    bodyPadding = bodyPadding.copyWith(
        left: Framework.templateDefaults.body.horizontalPadding,
        right: Framework.templateDefaults.body.horizontalPadding,
        top: bodyPadding.top
    );

    //bodyPadding = EdgeInsets.zero;
    double bodyHeight = getBodyHeight(navbarSize);

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      body = Container(
        //color: Colors.red,
        child: MultiChildScrollView(
            doubleDirection: screenModelBasedOnWidth() == DeviceType.mobile,
            scrollWidth: widget.definition.elementDefinition.realWidth,
            scrollHeight: bodyHeight,
            children: [
              Padding(
                padding: bodyPadding,
                child: body,
              ), /*
              Padding(
                padding: EdgeInsets.only(
                    top: widget.parent.navbarConfiguration.useTwoNavbars
                        ? 12
                        : 0),
                child: body,
              )*/
            ]),
      );
    }

    List<Widget> mainElements = [

      (!widget.definition.navbarConfiguration.useNavigatorAsBackground) ?
      TemplateTopNavbarContent(
        navbarConfiguration: NavbarConfiguration(
          padding: widget.definition.navbarConfiguration.useDefaultPadding
              ?Framework.templateDefaults.navbar.getPadding()
              : EdgeInsets.zero,
          appending: widget.definition.navbarConfiguration.appending,
          navbar: widget.definition.navbarConfiguration.navbar ??
              (widget.definition.navbarConfiguration.usesDefaultNavbar
                  ? Framework.templateDefaults.navbar.content
                  : null),
        ),
        height: widget.definition.navbarConfiguration.height,
      ) : Container(),
      widget.definition.elementDefinition.getElement(
          restrictedHeight: max(bodyHeight, 400),
          content: Column(
            children: [
              Container(
                child: Padding(
                  padding: widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody
                  ? EdgeInsets.zero : bodyPadding,
                  child: Container(
                      //color: Colors.blue,

                      child: body),
                ),
              )
            ],
          ),
          parentBody: widget.definition.bodyParent,
          background: widget.definition.background)
    ];

    if ([ScrollerBehaviour.onlyBody,
    ScrollerBehaviour.none,
    ].contains(widget.definition.scrollBehaviour)) {
      return SizedBox(
          width: widget.definition.elementDefinition.realWidth,
          // height: widget.parent.nullifyHeight ? null : bodyHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainElements,
          ));
    }


    return MultiChildScrollView(
        doubleDirection: true,
        scrollWidth: widget.definition.elementDefinition.realWidth,
        scrollHeight: bodyHeight,
        children: mainElements);
  }*/

}


/*import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:framework/shared_widgets/base_template/size_restriction_definition/restricted_element_definition.dart';
import 'package:framework/shared_widgets/base_template/template_scaffold.dart';

import '../../framework.dart';
import '../listing/multi_child_scroll_view.dart';
import '../responsive/media_queries.dart';

class BodyLayoutDefinition {
  final Widget background;
  final NavbarConfiguration navbarConfiguration;
  final AppbarConfiguration appbarConfiguration;
  final RestrictedElementDefinition elementDefinition;
  final ScrollerBehaviour scrollBehaviour;

  final Widget body;
  final bool useDefaultPadding;
  final Widget Function(BuildContext context, double realWidth, Widget body)?
      bodyParent;
  BodyLayoutDefinition({
    required this.background,
    required this.appbarConfiguration,
    required this.scrollBehaviour,
    required this.navbarConfiguration,
    required this.elementDefinition,
    required this.body,
    required this.useDefaultPadding,
    required this.bodyParent,
  });
}

class TemplateBodyLayout extends StatefulWidget {
  final BodyLayoutDefinition definition;

  const TemplateBodyLayout({
    required this.definition,
    Key? key,
  }) : super(key: key);

  @override
  State<TemplateBodyLayout> createState() => _TemplateBodyLayoutState();
}

class _TemplateBodyLayoutState extends State<TemplateBodyLayout> {
  @override
  void initState() {
    super.initState();
  }

  /*
  double getBodyHeight(navbarSize) {
    double bodyHeight = MediaQuery.of(context).size.height -
        (widget.definition.appbarConfiguration.ignorePadding
            ? 0
            : Framework.templateDefaults.appbar.height ?? 0);

    bodyHeight -= 27;
    if(!widget.definition.navbarConfiguration.useNavigatorAsBackground) {
      bodyHeight -= navbarSize;
    }



    if (widget.definition.navbarConfiguration.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.navbar.padding;
    }

    /*if (widget.definition.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.body.topPadding;
    }*/

    return bodyHeight;
  }*/

  double getBodyHeight(navbarPadding) {
    double bodyHeight = MediaQuery.of(context).size.height -
        (widget.definition.appbarConfiguration.ignorePadding
            ? 0
            : Framework.templateDefaults.appbar.height ?? 0);

    if (!widget.definition.navbarConfiguration.ignoreNavbarPadding) {
      bodyHeight -= navbarPadding;
    }

    if (widget.definition.navbarConfiguration.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.navbar.padding;
    }

    if (widget.definition.useDefaultPadding) {
      bodyHeight -= Framework.templateDefaults.body.topPadding;
    }

    return bodyHeight;
  }


  @override
  Widget build(BuildContext context) {
    Widget body = widget.definition.body;

    // #TODO  WHEN USING PATIENT HEADER, SPACE IN MOBILE OVERFLOWS

    EdgeInsets bodyPadding = widget.definition.useDefaultPadding
        ? EdgeInsets.only(top: Framework.templateDefaults.body.topPadding)
        : EdgeInsets.zero;

    double navbarPadding =
    (widget.definition.navbarConfiguration.ignoreNavbarPadding
        ? 0
        : widget.definition.navbarConfiguration.height);

    if (widget.definition.navbarConfiguration.useTwoNavbars) {
      double extraNavbarPadding = widget.definition.navbarConfiguration.height;
      navbarPadding += extraNavbarPadding;
    }

    bodyPadding = bodyPadding.copyWith(
        left: Framework.templateDefaults.body.horizontalPadding,
        right: Framework.templateDefaults.body.horizontalPadding,
        top: bodyPadding.top + navbarPadding);

    //bodyPadding = EdgeInsets.zero;
    double bodyHeight = getBodyHeight(navbarPadding);

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      body = Container(
        child: MultiChildScrollView(
            doubleDirection: screenModelBasedOnWidth() == DeviceType.mobile,
            scrollWidth: widget.definition.elementDefinition.realWidth,
            scrollHeight: bodyHeight,
            children: [
              body, /*
              Padding(
                padding: EdgeInsets.only(
                    top: widget.parent.navbarConfiguration.useTwoNavbars
                        ? 12
                        : 0),
                child: body,
              )*/
            ]),
      );
    }

    List<Widget> mainElements = [
      widget.definition.elementDefinition.getElement(
          restrictedHeight: max(bodyHeight, 400),
          content: Column(
            children: [
              Container(
                child: Padding(
                  padding: bodyPadding,
                  child: Container(
                    //color: Colors.blue,

                      child: body),
                ),
              )
            ],
          ),
          parentBody: widget.definition.bodyParent,
          background: widget.definition.background)
    ];

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      return SizedBox(
          width: widget.definition.elementDefinition.realWidth,
          // height: widget.parent.nullifyHeight ? null : bodyHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainElements,
          ));
    }

    return MultiChildScrollView(
        doubleDirection: true,
        scrollWidth: widget.definition.elementDefinition.realWidth,
        scrollHeight: bodyHeight,
        children: mainElements);
  }
  /*
  @override
  Widget build(BuildContext context) {

    MediaQuery.of(context).size;
    Widget body = widget.definition.body;

    // #TODO  WHEN USING PATIENT HEADER, SPACE IN MOBILE OVERFLOWS

    EdgeInsets bodyPadding = widget.definition.useDefaultPadding
        ? EdgeInsets.only(top: Framework.templateDefaults.body.topPadding)
        : EdgeInsets.zero;

    double navbarSize =
        (widget.definition.navbarConfiguration.height);

    if (widget.definition.navbarConfiguration.useTwoNavbars) {
      double extraNavbarPadding = widget.definition.navbarConfiguration.height;
      navbarSize += extraNavbarPadding;
    }

    bodyPadding = bodyPadding.copyWith(
        left: Framework.templateDefaults.body.horizontalPadding,
        right: Framework.templateDefaults.body.horizontalPadding,
        top: bodyPadding.top
    );

    //bodyPadding = EdgeInsets.zero;
    double bodyHeight = getBodyHeight(navbarSize);

    if (widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody) {
      body = Container(
        //color: Colors.red,
        child: MultiChildScrollView(
            doubleDirection: screenModelBasedOnWidth() == DeviceType.mobile,
            scrollWidth: widget.definition.elementDefinition.realWidth,
            scrollHeight: bodyHeight,
            children: [
              Padding(
                padding: bodyPadding,
                child: body,
              ), /*
              Padding(
                padding: EdgeInsets.only(
                    top: widget.parent.navbarConfiguration.useTwoNavbars
                        ? 12
                        : 0),
                child: body,
              )*/
            ]),
      );
    }

    List<Widget> mainElements = [

      (!widget.definition.navbarConfiguration.useNavigatorAsBackground) ?
      TemplateTopNavbarContent(
        navbarConfiguration: NavbarConfiguration(
          padding: widget.definition.navbarConfiguration.useDefaultPadding
              ?Framework.templateDefaults.navbar.getPadding()
              : EdgeInsets.zero,
          appending: widget.definition.navbarConfiguration.appending,
          navbar: widget.definition.navbarConfiguration.navbar ??
              (widget.definition.navbarConfiguration.usesDefaultNavbar
                  ? Framework.templateDefaults.navbar.content
                  : null),
        ),
        height: widget.definition.navbarConfiguration.height,
      ) : Container(),
      widget.definition.elementDefinition.getElement(
          restrictedHeight: max(bodyHeight, 400),
          content: Column(
            children: [
              Container(
                child: Padding(
                  padding: widget.definition.scrollBehaviour == ScrollerBehaviour.onlyBody
                  ? EdgeInsets.zero : bodyPadding,
                  child: Container(
                      //color: Colors.blue,

                      child: body),
                ),
              )
            ],
          ),
          parentBody: widget.definition.bodyParent,
          background: widget.definition.background)
    ];

    if ([ScrollerBehaviour.onlyBody,
    ScrollerBehaviour.none,
    ].contains(widget.definition.scrollBehaviour)) {
      return SizedBox(
          width: widget.definition.elementDefinition.realWidth,
          // height: widget.parent.nullifyHeight ? null : bodyHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: mainElements,
          ));
    }


    return MultiChildScrollView(
        doubleDirection: true,
        scrollWidth: widget.definition.elementDefinition.realWidth,
        scrollHeight: bodyHeight,
        children: mainElements);
  }*/

}
*/