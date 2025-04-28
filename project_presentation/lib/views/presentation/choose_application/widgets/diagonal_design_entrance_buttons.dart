


import 'package:flutter/material.dart';
import 'package:flexible_structures/widgets/base_templates/buttons/card_button_v1.dart';

import '../entrance_actions.dart';

class DiagonalDesignEntranceButtons extends StatelessWidget {
  final EntranceActions entranceActions;
  final CommonButtonUtility buttonUtility;
  const DiagonalDesignEntranceButtons({super.key,
    required this.buttonUtility,
    required this.entranceActions});

  @override
  Widget build(BuildContext context) {

    Radius radius = Radius.circular(12);
    Border;
    buttonUtility.borderShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomRight: radius,
        topRight: radius,
        bottomLeft: Radius.zero
      )
    );
    /*
    return EntranceButtons(
      entranceActions: entranceActions,
      buttonUtility: buttonUtility,
    );*/
   //buttonUtility.border = 0;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     /*   CardButtonV1(
          commonButtonUtility: buttonUtility,
          title: CardTextContent(
            content: const Text(textType: TextType.small, title: 'WEBSITE',
              paddingBottom: 0,
              textColorForTitle: Colors.white70,),
          ),
          borderShape: buttonUtility.borderShape,
          leadingIcon: CardIconData(

              icon: Icon(Icons.computer)
          ),
          trailingIcon: CardIconData(),
          onPress: (){
            entranceActions.openDesktop();
          },
        ),*/

        Button(title: 'WEBSITE',
        width: 72, height: 32,
        ),
      ],
    );
  }
}


class Button extends StatefulWidget {
  final String title;

  final double width;
  final double height;
  const Button({super.key, required this.title, required this.width, required this.height});
  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: widget.width,
        width: widget.height,
        child: Stack(children: [
          //Container(color: Colors.white),
          ClipPath(
            child: Container(
              width: widget.width,
              color: Colors.yellow,
              child: Center(child: Text(widget.title)),
              height: widget.height,
            ),
            clipper: CustomClipPath(width: widget.width,
            height: widget.height
            ),
          )
        ]));
  }
}

class CustomClipPath extends CustomClipper<Path> {

  final double width;
  final double height;
  CustomClipPath( {required this.width, required this.height,});

  @override
  Path getClip(Size size) {
    Path path = Path();

    double cornerFactor = 0.83;

    double initialHeight = height * (0.85/0.15);
    path.lineTo(0, initialHeight);
    path.lineTo(width*cornerFactor, height);
    path.lineTo(width, 0);
    path.lineTo(0, 0);
    path.lineTo(0, initialHeight);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}