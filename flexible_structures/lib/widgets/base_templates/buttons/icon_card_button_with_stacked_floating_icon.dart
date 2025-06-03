



import 'package:common_extensions/extensions/ui/for_build_context.dart';
import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../responsive/item_sizes.dart';
import 'icon_action_card_button.dart';

class IconCardButtonWithStackedFloatingIcon extends StatelessWidget {
  final Widget icon;
  final String content;
  final Function()? onPress;
  final IconPositioningInButton iconPositioningInDesktop;

  final CommonButtonUtility? buttonUtility;

  final bool useFloating;
  final bool notUseMobileVersion;
  final bool padContent;
  final ItemSize itemSize;

  final double buttonSize;

  const IconCardButtonWithStackedFloatingIcon({super.key,
    required this.icon, required this.content,
    this.onPress,
    this.buttonUtility,
    this.useFloating=true,
    this.padContent=false,
    this.buttonSize=48,
    this.itemSize=ItemSize.normal,
    this.notUseMobileVersion=false,
    required this.iconPositioningInDesktop});


  double? getWidth(BuildContext context) {

    return

    buttonUtility?.width ??
        ( isMobile() && notUseMobileVersion == false ? null :
      context.width*(isMobile() ? 0.4 : 0.18) * itemSize.defaultMultiplier);
  }
  @override
  Widget build(BuildContext context) {

    bool isUsingFloatingButton = ( useFloating);

    return Container(
     width:  getWidth(context),
      child: IconActionCardButton(content: content,
          //  forceMobile: true,
          cardWidth:getWidth(context),
          useIconInDesktop: true,
          buttonUtility: buttonUtility,
          padsContentFromStack: padContent,
          notUseMobileVersion: notUseMobileVersion,
          iconPositioningInDesktop: iconPositioningInDesktop,
          icon:

              Container(
                child: IgnorePointer(
                  child: isUsingFloatingButton ? Container(
                    width: buttonSize,
                    height: buttonSize,
                    child: FloatingActionButton(
                        onPressed: null,
                        backgroundColor: GetIt.I.get<FlexibleThemeColors>().getAppBackgroundColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)
                        ),
                        child: icon),
                  ) : icon,
                ),
              ),


          onPress:
              onPress  ),
    );
  }
}
