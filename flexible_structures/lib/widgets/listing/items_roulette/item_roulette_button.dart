


import 'dart:math';

import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';
import 'package:flexible_structures/widgets/interactions/opacity_on_hover.dart';
import 'package:flexible_structures/widgets/interactions/scale_on_hover.dart';
import 'package:flexible_structures/widgets/responsive/item_sizes.dart';
import 'package:flutter/material.dart';

import '../../../responsive/media_queries.dart';

class ItemRouletteButton extends StatefulWidget {
  final Function()? move;
  final IconData icon;
  final bool isVertical;
  const ItemRouletteButton({super.key, required this.move,
    required this.icon,
    this.isVertical = false
  });

  @override
  State<ItemRouletteButton> createState() => _ItemRouletteButtonState();
}

class _ItemRouletteButtonState extends State<ItemRouletteButton> {


  ValueNotifier<bool> _isHovered = ValueNotifier(false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isHovered.addListener(() {
      setState(() {

      });
    });
  }

  @override
  Widget build(BuildContext context) {

    Color? buttonBackground = Color(0x136da7db);
    Color? buttonBackgroundHovered = ( Theme.of(context).elevatedButtonTheme
        .style?.backgroundColor?.resolve(Set<MaterialState>()) ??
        Colors.blue);
    //buttonBackground = buttonBackgroundHovered;

    if(isMobile()) {
      //buttonBackground = buttonBackgroundHovered;
    }
    double cardWidth = 40;

    Widget icon = IgnorePointer(child: Icon(widget.icon,
        color: Colors.white
    ));

    if(widget.isVertical) {
      icon = Transform.rotate(angle: pi/2,
      child: icon,
      );
    }

    return Container(
      padding: widget.isVertical ? EdgeInsets.symmetric(horizontal: 12) : EdgeInsets.zero,
      width: widget.isVertical ? null : cardWidth,//50,1
      height: widget.isVertical ? cardWidth : null,
      child: SizedBox.expand(
        child: ScaleOnHover(
          notHovered: Matrix4.diagonal3Values(0.99,0.99, 0.99),
          child:
          true ?
              CardButtonV1(
                width:

                CardDimension(
                  nulify: true
                ),
                  backgroundOnlyParent: (context, background) {
                    return
                      //isMobile() ? background :
                      Container(
                        alignment: Alignment.center,
                      width:  widget.isVertical ? null : cardWidth,
                      height:  widget.isVertical ? cardWidth : null,
                      child: OpacityOnHover(
                          hoverNotifier: _isHovered,
                          child: background),
                    );
                  },

                  backgroundColor: buttonBackground,
                  hoverColor: buttonBackgroundHovered,
                  onPress: widget.move,
                  title: CardTextContent(
                    alignment: Alignment.center,
                    content: Center(
                    child: icon,
                                      ),
              padding: EdgeInsets.all(0),

              )) :
          IconActionCardButton(

          //  cardWidth: cardWidth,
            /**/backgroundOnlyParent: (context, background) {
            return Container(
              width: cardWidth,
              child: OpacityOnHover(
                  hoverNotifier: _isHovered,
                  child: background),
            );
          },
            mobileSize: ItemSize.minimal,
            icon: Container(
              width: cardWidth,
              child: Center(
                child: IgnorePointer(child: Icon(widget.icon,
                color: Colors.white // _isHovered.value ? Colors.black : Colors.white
                  ,)),
              ),
            ),
            content: '',
            backgroundColor: buttonBackground,
            hoverColor: buttonBackgroundHovered,
            forceMobile: true,
            onPress: widget.move,
          ),
        ),
      ),
    );
  }
}

