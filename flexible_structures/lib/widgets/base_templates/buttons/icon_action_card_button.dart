import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../responsive/media_queries.dart';
import '../../responsive/item_sizes.dart';
import 'card_button_v1.dart';


enum IconPositioningInButton {
  leading,
  trailing,
  leadingAsStack,
  trailingAsStack,
}

class IconActionCardButton extends StatelessWidget {
  final String content;
  final Widget icon;
  final double? iconSize;
  final Function()? onPress;
  final bool? pressEnabled;
  final bool invertColors;
  final Color? borderColor;
  final Color? backgroundColor;
  final Color? hoverColor;
  final Color? contentColor;
  final bool forceMobile;
  final bool useIconInDesktop;
  final ItemSize? desktopSize;
  final double? cardWidth;
  final ItemSize? mobileSize;

  final double numberOfIcons;
  final ShapeBorder? borderShape;
  final IconPositioningInButton iconPositioningInDesktop;

  final CommonButtonUtility? buttonUtility;
  final bool notUseMobileVersion;
  final bool padsContentFromStack;
  final Function(BuildContext context, Widget background)? backgroundOnlyParent;

  final double? height;

  final tooltip;
  const IconActionCardButton({
    Key? key,
    required this.content,
    required this.icon,
    this.numberOfIcons = 1,
    this.iconSize,
    this.desktopSize,
    this.mobileSize,
    this.backgroundOnlyParent,
    this.tooltip,
    required this.onPress,
    this.pressEnabled,
    this.padsContentFromStack=false,
    this.notUseMobileVersion=false,
    this.buttonUtility,
    this.forceMobile = false,
    this.useIconInDesktop = false,
    this.iconPositioningInDesktop=IconPositioningInButton.leading,
    this.invertColors = false,
    this.borderColor, this.borderShape,
    this.contentColor,
    this.cardWidth,
    this.hoverColor,
    this.height,
    this.backgroundColor,
  }) : super(key: key);

  bool useMobile() {
    return (isMobile() || forceMobile) && notUseMobileVersion == false ;
  }

  bool isUsingDesktopLeadingIcon() {
    return useIconInDesktop && !isMobile()

    && (iconPositioningInDesktop ==
    IconPositioningInButton.leading)
    ;
  }




  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;

    ItemSize itemSize = desktopSize ?? ItemSize.small;
    dynamic widgetContent = useMobile() ? icon : content;

    if (useMobile()) {
      itemSize = mobileSize ?? ItemSize.verySmall;
    }


    bool useStackedIcon =
        (iconPositioningInDesktop == IconPositioningInButton.leadingAsStack

        || iconPositioningInDesktop == IconPositioningInButton.trailingAsStack)

            //&& !isMobile()
            //&& !isMobile()
    ;


    double cardHeight = height ?? (iconSize == null ? 34.0 : (iconSize! + 8.0));
    Widget body =  CardButtonV1(
      tooltip: tooltip  ?? content,

      backgroundOnlyParent: backgroundOnlyParent,
      buttonSize: itemSize,

      commonButtonUtility: buttonUtility,
      cardIntention: CardIntention.action,
      height: CardDimension(size: cardHeight),
      borderColor: borderColor,
      borderShape: borderShape,
        rowMainAlignment: MainAxisAlignment.center,
      width: CardDimension(multiply: numberOfIcons,
      size: cardWidth
      ),
      hoverColor: hoverColor,
      backgroundColor: backgroundColor,
      title:

      CardTextContent(

        content: widgetContent,
        color: contentColor,
     //   padding: EdgeInsets.symmetric(horizontal: useStackedIcon ? 32 : 12),
        alignment:

           /* useStackedIcon ?
            ( iconPositioningInDesktop == IconPositioningInButton.leadingAsStack
            ? Alignment.centerRight :

        (
            iconPositioningInDesktop == IconPositioningInButton.trailingAsStack
                && !isMobile() ? Alignment.centerLeft :

            Alignment.center)) :*/
            Alignment.center
        ,
        flex:     useIconInDesktop && content == '' ? 0 : null,

      ),
      leadingIcon: isUsingDesktopLeadingIcon()
          ? CardIconData(
              padding: EdgeInsets.only(left: 6), icon: icon, useSpacing: true)
          : (
      iconPositioningInDesktop == IconPositioningInButton.trailing ?
      CardIconData(useSpacing: true) : null
      ),
      trailingIcon:
          iconPositioningInDesktop == IconPositioningInButton.trailing ?
              CardIconData(
                icon: icon
              )
              :
          ( content != '' &&
      isUsingDesktopLeadingIcon() ? CardIconData(useSpacing: true) : null ),
      onPress: onPress,
      pressEnabled: pressEnabled,
    );


    if( useStackedIcon ) {
      body =
          Stack(
            fit: StackFit.passthrough,
            alignment: Alignment.center,
            children: [
              Align(
                child: Padding(
                  padding:
                  padsContentFromStack ?
                  EdgeInsets.only(left:
                  iconPositioningInDesktop == IconPositioningInButton.trailingAsStack ?
                      0:
                  12, right:
                  iconPositioningInDesktop == IconPositioningInButton.trailingAsStack ?
                      12:
                  0,

                  ) : EdgeInsets.zero,
                  child: body,
                ),
                alignment: Alignment.center,
              ),
              Align(
                alignment:
                iconPositioningInDesktop == IconPositioningInButton.trailingAsStack
                ? Alignment.centerRight :
                Alignment.centerLeft,
                child: icon ,
              )
            ],
          );
    }

    return body;
  }


}
