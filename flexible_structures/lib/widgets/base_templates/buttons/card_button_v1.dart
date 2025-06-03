import 'dart:math';

import 'package:common_extensions/extensions/ui/for_padding.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../graphical_item/graphical_item.dart';


// # Don't use this widget, its left here for version reasons


enum CardIntention { display, action }

class CardDimension {
  double? size;
  bool nulify;
  double? multiply;
  double? maxValue;
  ItemSize? itemSize;

  CardDimension(
      {this.size,
      this.multiply,
      this.maxValue,
      this.nulify = false,
      this.itemSize});

  getValue({double? defaultDefinedValue}) {
    if (nulify) {
      return null;
    }

    if (size == null) {
      return defaultDefinedValue == null
          ? defaultDefinedValue
          : defaultDefinedValue * (multiply ?? 1);
    }
    return min((size)! * (multiply ?? 1), maxValue ?? double.infinity);
  }
}

class CardTextContent {
  final dynamic content;
  final Alignment? alignment;
  final TextStyle? textStyle;
  Color? color;
  final FontWeight? fontWeight;
  final double? size;
   int? flex;

  final EdgeInsets? padding;
  final Function()? press;
  final TextOverflow? textOverflow;

  static const EdgeInsets defaultPadding =
  EdgeInsets.symmetric(horizontal: 12, vertical: 0);

  CardTextContent({
    this.padding = defaultPadding ,
    this.content,
    this.alignment,
    this.textStyle,
    this.textOverflow,
    this.fontWeight,
    this.size,
    this.color,
    this.press,
    this.flex,
  });

  getStyle(CardButtonV1 cardButtonV1, BuildContext context) {
    return textStyle ??
        TextStyle(
            color: color ??

                Theme.of(context).buttonTheme.colorScheme?.surface ??
                (cardButtonV1.getBackgroundColor(context) == Colors.white
                    ? Colors.black
                    : Colors.white),
            fontSize: size ?? 14,
            overflow: textOverflow ?? TextOverflow.clip,
            fontWeight: fontWeight ?? FontWeight.w700);
  }

  static CardTextStyle({Color? color, backgroundColor,size, fontWeight,
  textOverflow}) {
    return  TextStyle(
        color: color ??
            (backgroundColor == Colors.white
                ? Colors.black
                : Colors.white),
        fontSize: size ?? 14,
        overflow: textOverflow ?? TextOverflow.clip,
        fontWeight: fontWeight ?? FontWeight.w700);
  }

  Widget getContent(CardButtonV1 cardButtonV1, BuildContext context) {
    Widget text = content is Widget
        ? content
        : Text(
            content,
            style: getStyle(cardButtonV1, context),
          );

    if (padding != null && flex != 0) {
      text = Padding(
        padding: padding!,
        child: text,
      );
    } else {
      if(cardButtonV1.buttonSize == ItemSize.minimal) {
        text = Padding(padding: EdgeInsets.all(12),
        child: text,);
      }
    }


    //if (alignment != null) {
      text = Align(
        alignment: alignment ?? Alignment.center,
        child: text,
      );
    //}

    if(press != null) {
      text =GestureDetector(
        onTap: press,
        child: text,
      );
    }



    return text;
  }
}

class CardIconData {
  final dynamic icon;
  final Color? color;
  final double? size;
  final Function()? press;
  final bool useSpacing;
  final bool hide;
  final EdgeInsets? padding;
  final int? iconFlex;
  final Color? backgroundColor;

  CardIconData(
      {this.iconFlex,
      this.icon,
      this.padding,
      this.color,
      this.size,
      this.press,
      this.useSpacing = true,
      this.hide = false,
      this.backgroundColor,
      this.height});

  final double? height;

  double getIconSize(context, cardButtonV1) {
    return {
          ItemSize.large: 32.0,
          ItemSize.big: 32.0,
          ItemSize.small: 24.0
        }[cardButtonV1.buttonSize] ??
        16;
  }

  Color getIconColor() {
    return Colors.white;
  }

  getIcon(
    context,
    CardButtonV1, {
    icon,
    color,
    double? size,
  }) {
    size ??= getIconSize(context, CardButtonV1);
    if (icon is GraphicalItem) {
      switch (icon.type) {
        case Graphical.icon:
          icon = icon.item;
          break;
        case Graphical.svg:
          return SvgPicture.asset(
            icon.item,
            width: size,
          );
        case Graphical.image:
          return Image.asset(icon.item);
      }
    }

    return icon is IconData
        ? Icon(
            icon,
            size: size,
            color: color ?? getIconColor(),
          )
        : icon;
  }

  Widget getContent(BuildContext context, CardButtonV1 cardButtonV1) {
    return hide
        ? Container()
        : Padding(
            padding: padding ?? EdgeInsets.zero,
            child: GestureDetector(
                onTap: press,
                child: getIcon(context, cardButtonV1,
                    icon: icon, color: color, size: size)),
          );
  }
}

/*
* class PressControl {
  bool? active;
  Function()? onPress;
  bool? pressEnabled;
* */


class CardButtonV1 extends StatelessWidget {
  final CardIntention? cardIntention;
  final bool usesInk;
  final bool usesNeumorphic;
  final double? borderRadius;
   bool? active;

  Function()? onPress;
  final bool? pressEnabled;
  void Function(PointerEnterEvent event)? onEnter;
  void Function(PointerExitEvent event)? onExit;
  int? flex;

  final double removeElevation = 0;

  final CardTextContent title;
  final CardTextContent? subtitle;

  final MainAxisSize rowMainAxis;

  final CardIconData? trailingIcon;
  final CardIconData? leadingIcon;

  Color? backgroundColor;
  Color? borderColor;
  final BorderSide? borderSide;
  final ShapeBorder? borderShape;
  final bool circleWrap;
  final MainAxisAlignment? rowMainAlignment;
  final String? tooltip;

  final Color? hoverColor;

   CardDimension? width;
  final CardDimension? height;

  final int flexMultiply;
  final ItemSize buttonSize;

  late CommonButtonUtility buttonUtility;
  final String? theme;

  final Color? stripColor;
  final EdgeInsets? sizePadding;

  final Function(BuildContext context, Widget background)? backgroundOnlyParent;

  CardButtonV1({
    super.key,
    required this.title,
    this.subtitle,
    this.cardIntention,
    this.usesInk = true,
    this.usesNeumorphic = false,
    this.active,
    this.leadingIcon,
    this.onPress,
    this.pressEnabled,
    this.onEnter,
    this.onExit,
    this.flexMultiply = 1,
    this.rowMainAlignment,
    this.width,
    this.height,
    this.borderRadius,
    this.buttonSize = ItemSize.normal,
    this.backgroundColor,
    this.tooltip,
    this.hoverColor,
    this.borderColor,
    this.borderSide,
    this.borderShape,
    this.rowMainAxis = MainAxisSize.max,
    this.circleWrap = false,
    this.stripColor,
    CommonButtonUtility? commonButtonUtility,
    this.theme,
    this.flex,
    this.trailingIcon,
    this.sizePadding,
    this.backgroundOnlyParent,
  }) {
    buttonUtility = commonButtonUtility ?? CommonButtonUtility();


    if(pressEnabled == false) {
      active = false;
    }
  }

  Map<String, Map<String, dynamic>> buttonThemes = {};


  double getDefaultBorder() {

    return CardButtonV1.getDefaultBordervalue(itemSize: buttonSize);
  }
  static double getDefaultBordervalue({required ItemSize itemSize}) {
    return itemSize == ItemSize.large ? 10.0 : 5.0;
  }

  String getTitleAsText() {
    return title.content.runtimeType == String ? title.content : "";
  }

  Function()? getOnPress() {
    return (pressEnabled ?? true) ? onPress : null;
  }

  getShapeBorder(BuildContext context) {
    BorderRadius cardRadius = BorderRadius.all(
        Radius.circular(getBorderRadius()));

    return buttonUtility.borderShape ?? borderShape ??
        RoundedRectangleBorder(
            side: borderSide ??
                BorderSide(color: borderColor ??
                    getBackgroundColor(context)!),
            borderRadius: cardRadius);
  }

  double getBorderRadius() {
    return buttonUtility.border ?? borderRadius
          ?? getDefaultBorder();
  }

  Color getBackgroundColor(BuildContext context) {
    if ((cardIntention == CardIntention.action && getOnPress() == null) ||
      (active != null && !active!)) {
    return const Color(0xffcccccc);
    }
    return backgroundColor ??
        ( Theme.of(context).elevatedButtonTheme
            .style?.backgroundColor?.resolve(Set<MaterialState>()) ??
        Colors.blue);
  }

  @override
  Widget build(BuildContext context) {
    if (buttonSize == ItemSize.minimal) {
      flex = 0;
    }


    CardButtonV1SizeResolver sizeResolver =
        CardButtonV1SizeResolver(buttonSize);


    width ??= CardDimension();

    double? cardWidth = width!.getValue(
        defaultDefinedValue: sizeResolver.resolveWidth(context, widget: this));

    if(buttonUtility.width != null) {
      cardWidth = buttonUtility.width;
    }


    double? cardHeight = height?.getValue(
            defaultDefinedValue:
                sizeResolver.resolveHeight(context, widget: this)) ??
        sizeResolver.resolveHeight(context, widget: this);

    // #todo: check if this is necessary?
    if (false) {
      double minWidth = buttonSize == ItemSize.smallish ? 100 : 160;
      cardWidth = (cardWidth == null) ? minWidth : max(cardWidth, minWidth);
    }

    if (buttonSize == ItemSize.unlimited) {
      cardWidth = null;
      cardHeight = null;
    }

    if (buttonSize == ItemSize.minimal) {
      cardWidth = null;
    }

    if (theme != null && buttonThemes.containsKey(theme)) {
      Map<String, dynamic> buttonTheme = buttonThemes[theme]!;
      backgroundColor = buttonTheme['color'];
      borderColor = buttonTheme['border'];
      title.color = buttonTheme['text'];
    }



    /*  backgroundColor ??= getUserPrimaryColor();

    if (backgroundColor == getAppBackgroundColor() && title.color == null) {
      title.color = Colors.black;
    }*/

    /* Widget button = InkWell(
      onTap: getOnPress(),
      borderRadius: cardRadius,
      customBorder: getShapeBorder(),
      hoverColor: hoverColor ??
          (backgroundColor == getUserPrimaryColor()
              ? getDarkPrimaryColor()
              : null),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth ?? double.infinity),
        child: SizedBox(
            width: cardWidth,
            height: cardHeight,
            child: _ButtonBody(CardButtonV1: this)),
      ),
    );*/

    Widget button = _ButtonShape(
      cardButton: this,
      cardWidth: cardWidth,
    );

    return  Material(

      type: MaterialType.transparency,
      child: Padding(
        padding: sizePadding == null
            ? EdgeInsets.zero
            : sizePadding!.multiply(EdgeInsets.only(
                top: cardHeight ?? 0,
                bottom: cardHeight ?? 0,
                left: cardWidth ?? 0,
                right: cardWidth ?? 0)),
        child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: cardWidth ?? double.infinity),
            child:
                Container(width: cardWidth, height: cardHeight, child: button)),
      ),
    );
  }
}

class _ButtonShape extends StatelessWidget {
  final CardButtonV1 cardButton;
  final double? cardWidth;
  const _ButtonShape(
      {Key? key, required this.cardWidth, required this.cardButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    Widget button = _ButtonBody(cardButtonV1: cardButton);
    Widget? buttonUpStack = null;


    if (cardWidth != null) {
      button = ConstrainedBox(
          constraints: BoxConstraints(maxWidth: cardWidth!),
          child: Container(width: cardWidth, child: button));
    }
    BorderRadius cardRadius = BorderRadius.all(Radius.circular(
      cardButton.getBorderRadius()
    ));

    if(cardButton.backgroundOnlyParent != null) {
      buttonUpStack = button;
      button = Container();
    }

    if (cardButton.usesInk) {
      button = InkWell(
          onTap: cardButton.getOnPress(),
          //borderRadius: cardRadius,
          customBorder: cardButton.getShapeBorder(context),
          hoverColor: cardButton
              .hoverColor /*??
              (cardButton.getBackgroundColor(context) == getUserPrimaryColor()
                  ? getDarkPrimaryColor()
                  : null) */
          ,
          child: button);
    }

    if (cardButton.circleWrap) {
      button = CircleAvatar(
        backgroundColor: cardButton.getBackgroundColor(context),
        child: button,
      );
    } else {
      if (cardButton.usesNeumorphic && false) {
        /*button = NeumorphicButton(
          onPressed: () async {
            if (cardButton.onPress == null) {
              return;
            }
            await Future.delayed(Duration(milliseconds: 400));
            cardButton.onPress!();
          },
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          style: NeumorphicStyle(
              color: cardButton.getBackgroundColor(context),
              //shadowDarkColor: cardButton.getBackgroundColor(context),
              // shadowLightColor: cardButton.getBackgroundColor(context)
              depth: 2),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: cardRadius,
                  border: cardButton.borderColor == null
                      ? null
                      : Border.all(color: cardButton.borderColor!)),
              child: button),
        );*/
      } else {
        button = Card(
          margin: EdgeInsets.zero,
          color: cardButton.getBackgroundColor(context),
          shape: cardButton.getShapeBorder(context),
          child: button,
        );
      }
    }

    if (cardButton.tooltip != null && cardButton.tooltip != '') {
      button = Tooltip(
        message: cardButton.tooltip,
        child: button,
      );
    }

    if (!(cardButton.usesInk || cardButton.usesNeumorphic) &&
        cardButton.onPress != null) {
      button = GestureDetector(
        onTap: cardButton.onPress,
        child: button,
      );
    }

    if (cardButton.onPress != null ||
        cardButton.onEnter != null ||
        cardButton.onExit != null) {
      button = MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: cardButton.onEnter,
        onExit: cardButton.onExit,
        child: button,
      );
    }

    if(buttonUpStack != null) {
      if(cardButton.backgroundOnlyParent != null) {
        button = cardButton.backgroundOnlyParent!(context, button);
      }

      button = Stack(
        children: [
          button,
          IgnorePointer(

            child: buttonUpStack
          ),
        ],
      );
    }

    return button;
  }
}

class _ButtonBody extends StatelessWidget {
  final CardButtonV1 cardButtonV1;
  const _ButtonBody({required this.cardButtonV1, Key? key}) : super(key: key);

  getElementFlex(int flex) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    if (minButton) {
      return 0;
    }

    return cardButtonV1.flex ?? (flex * cardButtonV1.flexMultiply);
  }

  isIconButton() {
    return (cardButtonV1.title.content == null ||
            cardButtonV1.title.content == "") &&
        (cardButtonV1.subtitle == null ||
            cardButtonV1.subtitle!.content == "") &&
        cardButtonV1.leadingIcon != null;
  }

  getSpacer({useSpacer = true, color}) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    if (minButton) {
      return Container();
    }

    if (!useSpacer) {
      return Container();
    }
    if (cardButtonV1.flex == 0) {
      return Container();
    }
    return Flexible(
        child: Container(
          color: color,
        ),
        flex: cardButtonV1.flex ?? 1);
  }

  getExpanded({Widget? child, flex, containerColor, height}) {
    if (child == null) {
      return Container();
    }
    if (flex == 0) {
      return child;
    }
    return Expanded(
      flex: cardButtonV1.flex ?? flex,
      child: Container(
        height: height,
        color: containerColor,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool minButton = cardButtonV1.rowMainAxis == MainAxisSize.min;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize:
      hasMinimalSize() ?
           MainAxisSize.min
          : cardButtonV1.rowMainAxis,
      mainAxisAlignment: cardButtonV1.rowMainAlignment ??
          (cardButtonV1.buttonSize.isBigger(ItemSize.normal)
              ? MainAxisAlignment.start
              : MainAxisAlignment.center),
      children: [
/*    */
        getSpacer(
            color: cardButtonV1.stripColor ??
                cardButtonV1.leadingIcon?.backgroundColor,
            useSpacer: cardButtonV1.leadingIcon?.useSpacing ??
                cardButtonV1.stripColor != null),

        getExpanded(
            height: cardButtonV1.leadingIcon?.height,
            flex: getElementFlex(cardButtonV1.leadingIcon == null
                ? 0
                : cardButtonV1.leadingIcon?.iconFlex ?? 2),
            child: cardButtonV1.leadingIcon?.getContent(context, cardButtonV1),
            containerColor: cardButtonV1.leadingIcon?.backgroundColor),

        getSpacer(useSpacer: cardButtonV1.leadingIcon?.useSpacing ?? false),
        isIconButton()
            ? Container()
            : getExpanded(
                flex: cardButtonV1.title.flex ?? getElementFlex(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  /*  crossAxisAlignment: minButton
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,*/
                  children: [
                    hasMinimalSize()
                        ? Container() :  Spacer(),
                    getExpanded(
                      flex: hasMinimalSize() ? 0 : 4,
                      child: cardButtonV1.title.getContent(cardButtonV1, context),),

                    cardButtonV1.subtitle == null
                    // || hasMinimalSize()
                        ? Container() :

                    Expanded(
                      flex:// hasMinimalSize() ? 0 :
                      3,
                      child: cardButtonV1.subtitle!.getContent(cardButtonV1, context),),


                    hasMinimalSize()
                        ? Container() : Spacer(),

                  ],
                ),
              ),

        getSpacer(useSpacer: cardButtonV1.trailingIcon?.useSpacing ?? false),

        isIconButton() || cardButtonV1.trailingIcon == null
            ? Container()
            : getExpanded(
                height: cardButtonV1.trailingIcon?.height,
                containerColor: cardButtonV1.trailingIcon?.backgroundColor,
                flex: getElementFlex(cardButtonV1.trailingIcon == null
                    ? 0
                    : cardButtonV1.trailingIcon!.iconFlex ?? 3),
                child: cardButtonV1.trailingIcon!
                    .getContent(context, cardButtonV1))

        //Spacer(flex: spacer,),
      ],
    );
  }

  bool hasMinimalSize() => cardButtonV1.height?.itemSize == ItemSize.minimal ||
      cardButtonV1.width?.itemSize == ItemSize.minimal ||
  cardButtonV1.buttonSize == ItemSize.minimal
  ;
}

class CommonButtonUtility {
  final double? width;
  final double? height;
  ShapeBorder? borderShape;
  ItemSize? itemSize;
  double? border;
  CommonButtonUtility({this.width, this.height,
    this.borderShape,
    this.itemSize,
    this.border});
}

class CardButtonV1SizeResolver extends ItemSizeResolver {
  CardButtonV1SizeResolver(super.itemSize);

  @override
  double? resolveHeight(context, {widget}) {
    ItemSize heightSize = (widget?.height?.itemSize) ?? itemSize;

    return {
      ItemSize.large: 110.0,
      ItemSize.big: 80.0,
      ItemSize.normal: 40.0,
      ItemSize.small: 40.0,
      ItemSize.smallish: 30.0,
      ItemSize.verySmall: 30.0,
    }[heightSize];
  }

  Map<ItemSize, double> widthResolver = {
    ItemSize.smallish: 0.08,
    ItemSize.small: 0.1,
    ItemSize.normal: 0.3,
    ItemSize.large: 0.8
  };

  Map<ItemSize, double> minWidthResolver = {
    ItemSize.small: 160,
    ItemSize.normal: 200,
  };

  Map<ItemSize, double> rawResolver = {
    ItemSize.verySmall: 50,
    ItemSize.smallish: 100
  };

  @override
  double? resolveWidth(context, {widget}) {
    widget = widget as CardButtonV1?;

    ItemSize widthSize = (widget?.width?.itemSize) ?? itemSize;
    double widthMultiply = widthResolver[widthSize] ?? 0.4;

    if (widget != null) {
      if (rawResolver.containsKey(widthSize)) {
        return rawResolver[widthSize];
      }

      if (widthSize == ItemSize.smallish &&
          widget.getTitleAsText().length > 12 &&
          (widget.width == null || widget.width!.multiply == null)) {
        widthMultiply *= 1.3;
      }
    }

    double width = MediaQuery.of(context).size.width * (widthMultiply);

    if (minWidthResolver.containsKey(itemSize)) {
      width = max(width, minWidthResolver[itemSize]!);
    }

    return width;
  }
}
