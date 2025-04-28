import 'dart:math';

import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/graphical_item/interactive_document/responsive_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ZoomButton extends StatelessWidget {
  final ImageSizeLoadingConfiguration imageConfiguration;
  final ValueNotifier<bool> zoomPicture;
  final TransformationController controller;
  const ZoomButton({
    Key? key,
    required this.imageConfiguration,
    required this.zoomPicture,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double iconPadding = min(40, MediaQuery.of(context).size.width * 0.04);

    double zoomRadius =
        max(min(27, MediaQuery.of(context).size.width * 0.03), 22);

    return Container(
      width: imageConfiguration.imageSizeWidth,
      height: imageConfiguration.imageSizeHeight,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: EdgeInsets.only(right: iconPadding, bottom: iconPadding),
          child: CircleAvatar(
            radius: zoomRadius,
            backgroundColor: /*zoomPicture ? BrandColors.adminPink :*/
                Colors.blueAccent,
            child: IconButton(
                onPressed: () {
                  zoomPicture.value = !zoomPicture.value;
                  if (zoomPicture.value) {
                    Matrix4 zoomValue = Matrix4.identity();

                    zoomValue.scale(2.0);
                    controller.value = zoomValue;
                  }
                },
                alignment: Alignment.center,
                icon: SvgPicture.asset(
                  "assets/${zoomPicture.value ? "/icons/zoom-out.svg" : "/icons/zoom.svg"}",
                  width: imageConfiguration.imageSizeWidth! /
                      (isMobile() ? 2 : 3 / 2),
                ) /*Icon(
                            zoomPicture ? Icons.zoom_out : Icons.zoom_in,
                            size: (imageSizeWidth*0.05), color: Colors.white)*/

                ),
          ),
        ),
      ),
    );
  }
}
