

import 'package:common_extensions/extensions/basic_types/for_double.dart';
import 'package:flexible_structures/responsive/responsive.dart';
import 'package:flexible_structures/widgets/animations/flipper/flipper_card.dart';
import 'package:flexible_structures/widgets/animations/flipper/flipper_screen.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/icon_card_button_with_stacked_floating_icon.dart';
import 'package:flexible_structures/widgets/display/dynamic_card.dart';
import 'package:flexible_structures/widgets/interactions/visiblity_on_hover/visibility_hover_cubit.dart';
import 'package:flexible_structures/widgets/interactions/visiblity_on_hover/visibility_on_hover_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/interactions/clickable.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';
import 'package:get_it/get_it.dart';
import '../models/application_option.dart';
import '../models/application_option_styling.dart';
import 'package:flexible_structures/dev/version_component_switch.dart';

class EntranceButton extends StatefulWidget {
  const EntranceButton({
    super.key,
    required this.optionStyling,
    required this.applicationOption,
    required this.buttonUtility,
    required this.isOnCenter,
    required this.everBeenInCenter
  });

  final bool isOnCenter;
  final bool everBeenInCenter;
  final ApplicationOptionStyling optionStyling;
  final ApplicationOption applicationOption;
  final CommonButtonUtility buttonUtility;

  @override
  State<EntranceButton> createState() => _EntranceButtonState();
}

class _EntranceButtonState extends State<EntranceButton> {

  ValueNotifier<bool> flippedNotifier = ValueNotifier(true);
  initState(){
    flippedNotifier.value = !widget.isOnCenter;


  }

  press(BuildContext context) {
    if (!widget.applicationOption.enabled) {
      return;
    }

    widget.applicationOption.open(context);
  }

  Function()? getPress(BuildContext context) {
    if (!widget.applicationOption.enabled) {
      return null;
    }

    if(widget.applicationOption.isLocked) {
      return null;
    }

    return () => press(context);
  }

  void dispose() {
    super.dispose();
    flippedNotifier.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget icon = widget.optionStyling.getIcon(widget.applicationOption);

    Widget card = ResponsiveWidget(
      desktop: DynamicCard(
        forceShowDisplay: widget.isOnCenter,
        useBorder: true,
        borderHighlighted: widget.isOnCenter && widget.applicationOption.enabled,
        display:
        widget.applicationOption.appState == ApplicationState.complete ?
        widget.applicationOption.optionName :
        "Em construção"
        ,
        useDisabledStyle: !widget.applicationOption.enabled, //widget.applicationOption.appState != ApplicationState.complete,
        relatedElement: widget.applicationOption,
        getPress: getPress,
        cardStyle: DynamicCardStyle(
          backgroundColor: getBackgroundColor(),
          textColor: getTextColor(),
        ),
        centerContent: icon,
      ),
      defaultWidget:

      /**/IconCardButtonWithStackedFloatingIcon(
        icon: icon,
        useFloating: false,
        notUseMobileVersion: true,
        content: widget.applicationOption.optionName,
        iconPositioningInDesktop: widget.applicationOption.iconPositioningInButton,
        onPress: getPress(context),
        buttonUtility: widget.buttonUtility,
      ),
    );

    if(widget.applicationOption.enabled == false) {
      card = FlippedScreen(
        boolValue: flippedNotifier,

          flipCardMethod:
          widget.everBeenInCenter ?
          FlipCardMethod.immediate  : FlipCardMethod.none ,

          backScreen:
          DynamicCard(useBorder: true,
            display: widget.applicationOption.optionName,
            relatedElement: widget.applicationOption,
            getPress: getPress,
            cardStyle: DynamicCardStyle(
              backgroundColor: getBackgroundColor(),
              textColor: getTextColor(),
            ),

            borderHighlighted: widget.isOnCenter,
            useDisabledStyle: true,
            centerContent: widget.optionStyling.getBackIcon != null ?
            widget.optionStyling.getBackIcon!(widget.applicationOption) :
            Text(
              widget.applicationOption.description ?? '',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ) ,
          screen: card);
    } else {
      /*card = ScaleOnHover(
        notHovered: Matrix4.identity(),
        child: card,
      );*/
    }

    return card;
  }

  Color getBackgroundColor() =>
      widget.applicationOption.enabled ?
      (widget.applicationOption.backgroundColor ??
          GetIt.I.get<FlexibleThemeColors>().getAppBackgroundColor()
       // Colors.white
      ) :
      GetIt.I.get<FlexibleThemeColors>().getDarkLight()
  ;

  Color getTextColor() =>
      widget.applicationOption.enabled ?
      (widget.applicationOption.textColor ?? Colors.black) :
      Color(0xfff1f1f1)
  ;
}

