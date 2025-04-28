import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flexible_structures/widgets/base_templates/template_scaffold.dart';


abstract class AppbarDefinition {
  dynamic get height;
  bool get restrictWidth;
}

class TemplateAppbar extends AppbarDefinition {
  Widget? content;
  Widget? background;
  final bool shouldRestrictWidth;

  @override
  double get height => 60;

  @override
  bool get restrictWidth => shouldRestrictWidth;

  TemplateAppbar(
      {this.shouldRestrictWidth = false, this.content, this.background});
}

abstract class NavbarDefinition {
  double get height;
}

class TemplateNavbar extends NavbarDefinition {
  Widget? content;

  @override
  double height = 45;
  double padding = 16;
  bool useAsBackground = false;


  EdgeInsets getPadding() {
    return EdgeInsets.symmetric(vertical: padding/2);
  }
}

class TemplateBackground {
  Widget? content;
}

class OverlayConfiguration {
  BuildContext context;
  bool useOverlay;
  OverlayConfiguration({required this.context, required this.useOverlay});
}

class TemplateBody {
  double get horizontalPadding => horizontalPad ??
      returnAppropriateGlobal(defaultResult: 12, mobile: 8);
  double topPadding = 72;
  double? horizontalPad;

  Function(OverlayConfiguration)? overlay;

  Function(BuildContext context, Widget body)? bodyWrapper;
}

class TemplateDefaults {
  TemplateNavbar navbar = TemplateNavbar();
  TemplateAppbar appbar = TemplateAppbar();
  TemplateBackground background = TemplateBackground();
  TemplateBody body = TemplateBody();


  Widget Function(BuildContext)? defaultFloatingActions;

  ScrollerBehaviour scrollerBehaviour = ScrollerBehaviour.onlyBody;

  bool usesDrawer = false;
  Widget? drawer;
}
