
import 'package:common_extensions/extensions/basic_types/for_double.dart';
import 'package:flexible_structures/dev/version_component_switch.dart';
import 'package:flexible_structures/widgets/interactions/clickable.dart';
import 'package:flexible_structures/widgets/interactions/visiblity_on_hover/visibility_hover_cubit.dart';
import 'package:flexible_structures/widgets/interactions/visiblity_on_hover/visibility_on_hover_element.dart';
import 'package:flexible_structures/widgets/theme_related/flexible_theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';



class DynamicCardStyle {
  final Color backgroundColor;
  final Color? textColor;

  DynamicCardStyle({
    required this.backgroundColor,
    this.textColor,
  });
}


enum DynamicCardDisplayTextLocation {
  top,
  bottom,
}

class DynamicCard extends StatefulWidget {
  final relatedElement;
  final Function()? Function(BuildContext context)? getPress;
  final Widget centerContent;
  final DynamicCardStyle? cardStyle;
  final String? display;
  final Widget? bottom;

  final DynamicCardDisplayTextLocation displayTextLocation;

  final bool? forceShowDisplay;
  final bool useBorder;
  final bool useDisabledStyle;
  final bool borderHighlighted;

  const DynamicCard({super.key,
    required this.relatedElement,
    this.getPress,
    required this.centerContent,
    this.display,
    this.forceShowDisplay,
    this.useDisabledStyle=false,
    this.useBorder=false,
    this.displayTextLocation = DynamicCardDisplayTextLocation.bottom,
    this.cardStyle, this.bottom,  this.borderHighlighted=false});

  @override
  State<DynamicCard> createState() => _DynamicCardState();

}

class _DynamicCardState extends State<DynamicCard> {


  @override
  Widget build(BuildContext context) {

    EdgeInsets padding =  EdgeInsets.symmetric(horizontal: 4);


    Color borderColor = widget.borderHighlighted ?
    (
        widget.useDisabledStyle ?
        GetIt.I.get<FlexibleThemeColors>().getBlack() :
        GetIt.I.get<FlexibleThemeColors>().getMainColor())
        : GetIt.I.get<FlexibleThemeColors>().getReadableGray();

    return VersionComponentSwitch(
        maxVersion: 2,
        startVersion: 0,
        enabled: false,
        builder: (context, v) {

          bool useBorder = v == 1 || widget.useBorder;

          // uses this visibility to affect the DisplayText visibility
          return VisibilityOnHoverElement(
            initialVisibility: false,
            forceShowDisplay: widget.forceShowDisplay ?? true,
            child: InkWell(
                onTap: widget.getPress == null ? null :
                widget.getPress!(context),
                child:

                Card(
                  color: widget.cardStyle?.backgroundColor,
                  shape: useBorder ? RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12) ,
                    side:BorderSide(width: 2.0,
                        color:
                        borderColor
                    ) ,
                  ): null,
                  child: Column(
                    // mainAxisSize: MainAxisSize.max,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        //color: Colors.blue,
                        child: Padding(
                          padding: padding,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [

                              widget.displayTextLocation ==
                                  DynamicCardDisplayTextLocation.top ?
                              Align(
                                alignment: Alignment.center,
                                child: DynamicCardDisplayText(

                                  textColor: useBorder ? Colors.white : widget.cardStyle?.textColor,
                                  color:
                                  widget.useDisabledStyle ?
                                  GetIt.I.get<FlexibleThemeColors>().getReadableGray() :
                                  borderColor,
                                  widget: widget,),
                              )
                                  : Container(),
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0,top: 8),
                                child: Row(
                                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [

                                    widget.relatedElement is FavoriteItem ?
                                    DiamondCheckbox(
                                      useDisabledStyle: widget.useDisabledStyle,
                                      favorableItem: widget.relatedElement,

                                    ) : Container(),

                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                          flex: 3 ,
                          child: Padding(
                            padding: padding,
                            child: Center(child: widget.centerContent),
                          )),

                      widget.bottom is Expanded ? widget.bottom!  :
                      Container(
                          child: Padding(padding: padding.copyWith(
                              bottom: 12
                          ),
                            child:  widget.bottom ?? Container(),
                          )
                      ),
                      widget.displayTextLocation ==
                          DynamicCardDisplayTextLocation.bottom ?

                      DynamicCardDisplayText(
                        textColor: //useBorder && widget.borderHighlighted
                        true
                            ? Colors.white : widget.cardStyle?.textColor,
                        color: //widget.useDisabledStyle ? NautilusThemeColors.getReadableGray() :
                        borderColor,
                        widget: widget,) : Container()

                    ],
                  ),
                )),
          );
        }
    );
  }
}

class DynamicCardDisplayText extends StatelessWidget {
  const DynamicCardDisplayText({
    super.key,
    required this.widget,
    required this.color,
    required this.textColor,
  });

  final DynamicCard widget;
  final Color color;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VisibilityHoverCubit, bool>(
      builder: (context, state) {
        return Visibility(
            visible:
            widget.display != null && state,
            maintainSize: true,
            maintainAnimation: true,
            maintainState: true,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  color:
                  color,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2.0),
                    child: Text(widget.display ?? '',

                      style: TextStyle(
                          color: textColor
                      ),
                    ),
                  ),
                ),
              ],
            ));
      },
    );
  }
}


abstract class FavoriteItem {

  bool favorite = false;

}

class DiamondCheckbox extends StatefulWidget {

  final FavoriteItem favorableItem;
  final bool useDisabledStyle;

  const DiamondCheckbox({super.key
    ,
    this.useDisabledStyle=false,
    required this.favorableItem,});

  @override
  State<DiamondCheckbox> createState() => _DiamondCheckboxState();
}

class _DiamondCheckboxState extends State<DiamondCheckbox> {


  @override
  Widget build(BuildContext context) {

    return widget.favorableItem.favorite ?
    Transform.translate(
      offset:Offset(-10, -0),
      child: Clickable(
        onPress: changeFavorited,
        child: Transform.rotate(angle: 45.0.toRadians(),
          child: Container(
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Colors.yellow,
            ),
          ),
        ),
      ),
    )
        :
    Checkbox(value: widget.favorableItem.favorite,
      fillColor: WidgetStatePropertyAll(
      //  widget.useDisabledStyle ? GetIt.I.get<FlexibleThemeColors>().getBlack() :
            GetIt.I.get<FlexibleThemeColors>().getAppBackgroundColor()
      ),
      side: BorderSide(
          color: widget.useDisabledStyle ? GetIt.I.get<FlexibleThemeColors>().getSlightDeactivatedColor() :
          GetIt.I.get<FlexibleThemeColors>().getBlack(),
          width: 2
      ),
      onChanged: (bool? value) {
        changeFavorited();
      },

    );
  }

  void changeFavorited() {
    setState(() {
      widget.favorableItem.favorite = !widget.favorableItem.favorite;
    });
  }
}
