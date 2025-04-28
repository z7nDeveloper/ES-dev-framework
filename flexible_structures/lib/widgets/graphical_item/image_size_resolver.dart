

import 'dart:async';

import 'package:flutter/material.dart';



class ImageSizeResolver extends StatelessWidget {

  final Image image;
  final AsyncWidgetBuilder builder;
  const ImageSizeResolver({required this.builder, required this.image, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    Completer<ImageInfo> completer = Completer<ImageInfo>();

    image.image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener(
            (ImageInfo info, bool _) {

          completer.complete(info);
        }));

    return FutureBuilder(
        future: completer.future,
        builder: builder
    );
  }
}
