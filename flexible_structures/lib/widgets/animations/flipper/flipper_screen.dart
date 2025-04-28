import 'package:flexible_structures/widgets/animations/flipper/flipper_card.dart';
import 'package:flexible_structures/widgets/display/screen_panel.dart';
import 'package:flutter/material.dart';


class FlippedScreen extends StatefulWidget {
  const FlippedScreen({
    super.key,
    required this.screen,
    this.boolValue,
    this.height,
    this.flipCardMethod=FlipCardMethod.onClick,
    this.backScreen,
  });

  final Widget screen;
  final Widget? backScreen;
  final double? height;
  final FlipCardMethod flipCardMethod;
  final ValueNotifier<bool>? boolValue;

  @override
  State<FlippedScreen> createState() => _FlippedScreenState();
}

class _FlippedScreenState extends State<FlippedScreen> {
  bool flip = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.boolValue != null) {
      widget.boolValue!.addListener(() {
        setState(() {
        });
      });
    }


    if(widget.flipCardMethod == FlipCardMethod.immediate  ) {

      flip = !widget.boolValue!.value;

      Future.delayed(Duration(microseconds: 300)).then(
          (_) {
            setState(() {

              flip = widget.boolValue!.value;
            });
          }
      );
    }

  }

  @override
  Widget build(BuildContext context) {

    Widget backCard = widget.backScreen ?? ScreenPanel();

    if(widget.flipCardMethod == FlipCardMethod.onClickBack) {
      backCard = GestureDetector(
        onTap: callFlip,
        child: backCard,
      );
    }

    Widget flipCard = FlipCard(
      toggler:
      widget.flipCardMethod == FlipCardMethod.immediate ? flip :
      widget.boolValue?.value ?? flip,
      backCard: backCard,
      frontCard: widget.screen,
    );

    if(widget.flipCardMethod == FlipCardMethod.onClick)  {
      flipCard =
          true ? GestureDetector(
            onTap: callFlip,
            child: flipCard,
          ) :
          Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: GestureDetector(
          onTap: callFlip,
          child: flipCard,
        ),
      );
    }

    return flipCard;
  }

  void callFlip(){
    setState(() {
      if(widget.boolValue != null) {

        widget.boolValue!.value = !widget.boolValue!.value;
        return;
      }

      flip = !flip;
    });
  }
}