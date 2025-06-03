import 'dart:math';

import 'package:flexible_structures/widgets/base_templates/buttons/icon_action_card_button.dart';
import 'package:flexible_structures/widgets/interactions/opacity_on_hover.dart';
import 'package:flexible_structures/widgets/interactions/scale_on_hover.dart';
import 'package:flexible_structures/widgets/interactions/swipe_detector.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/bloc/items_roulette_bloc.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/item_roulette_button.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/item_roulette_card_item.dart';
import 'package:flexible_structures/widgets/utils/clickable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


enum RouletteItemStyle {
  expandedCard,
}

enum RouletteType {
  horizontal,
  vertical
}

class ItemsRoulette<T> extends StatefulWidget {
  final Function(T item, int index) itemBuilder;
  final Widget Function(List<Widget>)? parentBuilder;
  final List<T> items;

  final double Function(T item, int index, int currentItemIndex)? cardWidthBuilder;
  final double? cardWidth;
  final double? cardHeight;
  final int itemsAtATime;

  final ItemsMovementRouletteBloc? movementBloc;

  final bool provideFixating;
  final RouletteItemStyle? itemStyle;

  final Widget? firstActionButton;
  final MainAxisAlignment? alignment;
  final Function(T item)? onItemClicked;

  final bool isInfinite;
  final bool useLeftAndRightAnimations;
  final EdgeInsets? internalContentPadding;
  final bool showNextItemsAsPreview;
  final String? emptyCase;

  final RouletteType rouletteType;


  const ItemsRoulette({
    super.key,
    this.itemsAtATime = 2,
    this.movementBloc,
    this.emptyCase,
    this.provideFixating = false,
    this.isInfinite = false,
    this.showNextItemsAsPreview = false,
    this.useLeftAndRightAnimations=false,
    this.firstActionButton,
    this.itemStyle,
    required this.itemBuilder,
    required this.items,
    this.cardWidth,
    this.cardWidthBuilder,
    this.cardHeight,
    this.parentBuilder,
    this.alignment,
    this.onItemClicked,
    this.internalContentPadding,
    this.rouletteType=RouletteType.horizontal,
  });

  @override
  State<ItemsRoulette<T>> createState() => _ItemsRouletteState<T>();
}

class _ItemsRouletteState<T> extends State<ItemsRoulette<T>> {
  ItemsMovementRouletteBloc? movementBloc = null;

  @override
  initState() {
    super.initState();
    movementBloc ??= widget.movementBloc;
    movementBloc ??= SimpleItemsMovementRouletteBloc(
        isInfinite: widget.isInfinite
    );
  }

  T? getOneItemBeyondViewableItems() {

    int upperLimit =
    min(widget.items.length, movementBloc!.state + widget.itemsAtATime);
    return widget.items.length > upperLimit
        ? widget.items[upperLimit]
        : null;
  }

  List<T> getViewableItems() {
    List<T> list = [];

    //list.add(widget.items[trackIndex]);


    int upperLimit =
    min(widget.items.length, movementBloc!.state + widget.itemsAtATime);
    for (int i = movementBloc!.state; i < upperLimit; i++) {
      list.add(widget.items[i]);
    }

    if(widget.isInfinite) {
      int remaining = widget.itemsAtATime - (upperLimit - movementBloc!.state);
      for(int i = 0; i < remaining; i++) {
        list.add(widget.items[i]);
      }
    }

    return list;
  }

  moveLeft() {
    movementBloc!.add(RouletteClickedLeftEvent(
      itemsAtATime: widget.itemsAtATime,
      itemsLength: widget.items.length,
    ));
  }

  moveRight() {
    int itemsLength = widget.items.length;

    movementBloc!.add(RouletteClickedRightEvent(
        itemsLength: itemsLength, itemsAtATime: widget.itemsAtATime));
  }

  bool canMoveLeft() {
    return widget.isInfinite
        ? true
        : movementBloc!.state > 0;
  }

  bool canMoveRight() {
    return widget.isInfinite
        ? true : (movementBloc!.state) < widget.items.length - widget.itemsAtATime;
  }

  Widget getItemCard(T item, int index, double? trackItemSize) {

    Duration switchAnimationDuration = Duration(milliseconds: 900);
    Widget itemWidget = widget.itemBuilder(item, index);

    int currentItemIndex = (index < movementBloc!.state) ? -1 :
    (index - movementBloc!.state  );

    Widget cardItem =ItemRouletteCardItem(
      key:
      !widget.useLeftAndRightAnimations ?
      null :
      index != 0 && index != 2 ? null :
      ValueKey(widget.items.indexOf(item)),
      child: itemWidget,
      onItemClicked: widget.onItemClicked,
      trackItemSize: trackItemSize ??
          (widget.cardWidthBuilder == null ?
          null :
          widget.cardWidthBuilder!(item, index, currentItemIndex)),
      itemStyle: widget.itemStyle,
      item: item,
    );

    return !widget.useLeftAndRightAnimations
        ? cardItem :
    (index == 2) ?

    AnimatedSwitcher(
      duration: switchAnimationDuration, // Animation duration
      transitionBuilder: (child, animation) {

        if(movementBloc!.lastMovingDirection != -1) {
          return child;
        }

        // Slide animation
        Animation<Offset> slideAnimation = Tween<Offset>(
          begin: Offset(1.0, 0),
          end: Offset.zero,
        ).animate(animation);

        // Fade animation
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: cardItem,
    )
        :
    index != 0 ?
    cardItem :

    AnimatedSwitcher(
      duration: switchAnimationDuration, // Animation duration
      transitionBuilder: (child, animation) {


        if(movementBloc!.lastMovingDirection != 1) {
          return child;
        }
        // Slide animation
        Animation<Offset> slideAnimation = Tween<Offset>(
          begin: Offset(-1.0, 0),
          end: Offset.zero,
        ).animate(animation);

        // Fade animation
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: slideAnimation,
            child: child,
          ),
        );
      },
      child: cardItem,
    );
  }

  @override
  Widget build(BuildContext context) {
    double? trackItemSize = widget.cardWidth == null
        ? null
        : widget.cardWidth! * 0.6 // (isMobile() ? 0.6 : 0.4)
        ;

    Color? buttonBackground = Color(0x136da7db);
    Color? buttonBackgroundHovered = ( Theme.of(context).elevatedButtonTheme
        .style?.backgroundColor?.resolve(Set<MaterialState>()) ??
        Colors.blue);


    return BlocBuilder<ItemsMovementRouletteBloc, int>(
      bloc: movementBloc,
      builder: (context, state) {

        if(widget.rouletteType == RouletteType.vertical) {

          List<Widget> children = getRouletteChildren(trackItemSize);

          return SwipeDetector(
            onSwipeDown: () {
              moveLeft();
            },
            onSwipeUp: () {
              moveRight();
            }  ,
            child: Column(
              children: [

                ItemRouletteButton(
                    move: canMoveLeft() ? moveLeft : null,
                    icon: Icons.keyboard_arrow_left,
                  isVertical: true,
                ),
                Expanded(child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: children
                )),

                ItemRouletteButton(
                    move: canMoveRight() ? moveRight : null,
                    icon: Icons.keyboard_arrow_right,

                  isVertical: true,
                ),

              ],
            ),
          );
        }

        return Column(
          mainAxisAlignment: widget.alignment ?? MainAxisAlignment.center,
          children: [
            // Expanded(child: Container()),
            Expanded(
              flex: 2,
              child:
              true  ?
                  Stack(
                    fit:  StackFit.passthrough,
                    alignment: Alignment.center,
                    children: [
/*
                      Container(
                          height: double.infinity
                      ),*/
                       widget.items.length == 0 ?
                      Center(
                        child: Text(
                            widget.emptyCase ??
                            'Nenhum item encontrado')
                      ) :
                           Padding(
                             padding: widget.internalContentPadding ?? EdgeInsets.only(),
                             child: BlocBuilder<ItemsMovementRouletteBloc, int>(
                               bloc: movementBloc,
                               builder: (context, state) {
                                 List<Widget> children = getRouletteChildren(trackItemSize);


                                 if(widget.showNextItemsAsPreview) {
                                   T? nextItem = getOneItemBeyondViewableItems();
                                   
                                 }
                                 return Container(
                                     alignment: Alignment.center,
                                     height: widget.cardHeight == null
                                         ? null
                                         : widget.cardHeight! * 0.5,
                                     //   width: trackItemSize * 2,
                                     child: widget.parentBuilder != null
                                         ? widget.parentBuilder!(children)
                                         : Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                       //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: children,
                                     ));
                               },
                             )
                           )
                      ,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: ItemRouletteButton(
                          move: canMoveLeft() ? moveLeft : null,
                          icon: Icons.keyboard_arrow_left
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child:

        ItemRouletteButton(
                          move: canMoveRight() ? moveRight : null,
                          icon: Icons.keyboard_arrow_right
                        ),

                      ),
                    ],
                  )

                  :
              Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconActionCardButton(
                    icon: Icon(Icons.keyboard_arrow_left),
                    content: '',
                    backgroundColor: buttonBackground,
                    hoverColor: buttonBackgroundHovered,
                    forceMobile: true,
                    onPress: canMoveLeft() ? moveLeft : null,
                  ),
                  Expanded(
                    flex: 1,
                    child: BlocBuilder<ItemsMovementRouletteBloc, int>(
                      bloc: movementBloc,
                      builder: (context, state) {
                        List<Widget> children = [];

                        if (widget.firstActionButton != null) {
                          children.add(
                              widget.firstActionButton!  );
                        }

                        for (T item in getViewableItems()) {
                          Widget itemWidget = widget.itemBuilder(item, 0);

                          children.add(ItemRouletteCardItem(
                            child: itemWidget,
                            onItemClicked: widget.onItemClicked,
                            trackItemSize: trackItemSize,
                            itemStyle: widget.itemStyle,
                            item: item,
                          ));
                        }

                        if(children.isEmpty) {
                          return Center(
                            child: Text('Nenhum item encontrado'),
                          );
                        }
                        return Container(
                            alignment: Alignment.center,
                            height: widget.cardHeight == null
                                ? null
                                : widget.cardHeight! * 0.5,
                            //   width: trackItemSize * 2,
                            child: widget.parentBuilder != null
                                ? widget.parentBuilder!(children)
                                : Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceEvenly,
                              children: children,
                            ));
                      },
                    ),
                  ),

                  IconActionCardButton(
                    icon: Icon(Icons.keyboard_arrow_right),
                    content: '',
                    forceMobile: true,
                    backgroundColor: buttonBackground,
                    hoverColor: buttonBackgroundHovered,
                    onPress: canMoveRight() ? moveRight : null,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> getRouletteChildren(double? trackItemSize) {
    List<Widget> children = [];

    if (widget.firstActionButton != null) {
      children.add(
          widget.firstActionButton!  );
    }


    int index = 0;
    for (T item in getViewableItems()) {

      children.add(
           getItemCard(item, index, trackItemSize)
          );
      index++;
    }
    return children;
  }
}



