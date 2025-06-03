
import 'package:flutter/material.dart';


class BackgroundCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double? opacity;
  final double? width;
  final double? height;
  const BackgroundCard({Key? key, required this.child, this.color, this.width, this.height, this.opacity,}) : super(key: key);

  static bool useMoreShadows = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.passthrough, 
      children: [
        Positioned.fill( 
          child: Opacity(
            opacity: opacity ?? 0.15,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: color ?? Color(0xffffffff),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                  if(useMoreShadows)
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 1),
                  ),
                ],
                borderRadius: BorderRadius.all(
                  Radius.circular(12.0),
                ),
              ),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
