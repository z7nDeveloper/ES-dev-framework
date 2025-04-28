




import 'package:common_extensions/extensions/basic_types/for_list.dart';
import 'package:flexible_structures/widgets/listing/items_roulette/item_roulette_button.dart';
import 'package:flutter/material.dart';

class ItemsRouletteScroll<T> extends StatefulWidget {
  final List<T> items;
  final double itemWidth;
  final double itemSpacing;
  final bool isLooping;
  const ItemsRouletteScroll({super.key, required this.items, required this.itemWidth, required this.itemSpacing, required this.isLooping});

  @override
  State<ItemsRouletteScroll<T>> createState() => _ItemsRouletteScrollState<T>();
}

class _ItemsRouletteScrollState<T> extends State<ItemsRouletteScroll<T>> {

  ScrollController scrollController = ScrollController();

  List items = [];
  int index = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items = widget.items.copy();

    // 1,2,3,4 becomes 4,1,2,3,4,1,2 so we can go back and forth
    if(widget.isLooping && widget.items.length > 1) {
      items.insert(0, items[items.length - 1]);
      items.add(items[1]);
      items.add(items[2]);
      index =  items.length - 3;
    }
    WidgetsBinding.instance.scheduleFrameCallback((_) {
      animateToIndex();
    });
  }

  double getCurrentPosition() {
    return (true ? 0  : scrollController.position.minScrollExtent) + (
        (widget.itemWidth/2)+
            index * (widget.itemWidth + widget.itemSpacing));
  }

  moveToIndex() async {
    scrollController.jumpTo(
      getCurrentPosition()
    );
  }

  animateToIndex() async {
    setState(() {

    });
     if(widget.isLooping) {
      if(index == 0) {
        index = items.length - 2;
        moveToIndex();
        index = items.length - 3;
      } else {
        if(index == items.length - 2) {
          index = 0;
          moveToIndex();
          index = 1;
        }
      }


    }

    await scrollController.animateTo(
      getCurrentPosition(),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut
    );

  }

  moveLeft() {

    index = index - 1 ;
    animateToIndex();
  }

  moveRight() {
    index = index + 1;
    animateToIndex();
  }

  bool canMoveLeft() {

    return
      (widget.isLooping && widget.items.length > 1) ||
    index > 0;
  }

  bool canMoveRight() {
    return
      (widget.isLooping && widget.items.length > 1) || (index) < items.length - 3;
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      fit:  StackFit.passthrough,
      alignment: Alignment.center,
      children: [
        ListView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,

          children: [
            ...items.map((item) => Padding(
              padding: EdgeInsets.only(
                  right: items.indexOf(item) ==
                   items.length - 1 ? 0 : widget.itemSpacing
              ),
              child: Container(
                width: widget.itemWidth,
                child:
               item is Widget ? item :
                Card(
                  child: Center(
                    child: Text(
                      item.toString(),
                    ),
                  ),
                ),
              ),
            )).toList(),
          ],
        ),
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
    );
  }
}
