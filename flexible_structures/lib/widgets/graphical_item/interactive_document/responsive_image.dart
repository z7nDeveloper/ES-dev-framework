import 'package:flutter/cupertino.dart';

import '../image_size_resolver.dart';
import '../on_error_image.dart';
import 'interactive_document.dart';

class ImageSizeLoadingConfiguration {
  double? imageSizeWidth;
  double? imageSizeHeight;
  String? imageFileName;
  Image? image;

  ImageSizeLoadingConfiguration(
      {this.imageSizeWidth,
      this.imageFileName,
      this.imageSizeHeight,
      this.image});

  void setSize(double width, double height) {
    imageSizeHeight = height;
    imageSizeWidth = width;
  }

  Image getImage({fit}) {
    if (image != null) {
      return image!;
    }

    return Image.asset(
      imageFileName!,
      errorBuilder: (context, error, stackTrace) {
        return OnErrorImage();
      },
      fit: fit,
    );
  }
}

class ResponsiveImage extends StatefulWidget {
  final double imageSize;
  final String? imageFileName;
  final ImageSizeLoadingConfiguration? imageSizeLoadingConfiguration;
  final Function(ImageSizeLoadingConfiguration) imageBuilder;
  final ImageRatioRelativeTarget imageRatioUse;

  const ResponsiveImage({
    Key? key,
    required this.imageSize,
    this.imageFileName,
    this.imageSizeLoadingConfiguration,
    required this.imageBuilder,
    required this.imageRatioUse,
  }) : super(key: key);

  @override
  State<ResponsiveImage> createState() => _ResponsiveImageState();
}

class _ResponsiveImageState extends State<ResponsiveImage> {
  ImageSizeLoadingConfiguration? imageSizeLoadingConfiguration;
  @override
  void initState() {
    super.initState();
    imageSizeLoadingConfiguration = widget.imageSizeLoadingConfiguration ??
        ImageSizeLoadingConfiguration(imageFileName: widget.imageFileName);
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;

    return ImageSizeResolver(
        image: imageSizeLoadingConfiguration!.getImage(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          double imageWidth = snapshot.data!.image.width;
          double imageHeight = snapshot.data!.image.height;
          double imageRatio = imageWidth / imageHeight;

          double imageSizeWidth = getImageWidth(imageRatio);
          double imageSizeHeight = getImageHeight(imageRatio);

          MediaQuery.of(context).size.width;
          imageSizeLoadingConfiguration!
              .setSize(imageSizeWidth, imageSizeHeight);
          return widget.imageBuilder(imageSizeLoadingConfiguration!);
        });
  }

  double getImageWidth(imageRatio) {
    if (imageRatio == ImageRatioRelativeTarget.width) {
      return widget.imageSize / imageRatio;
    }

    return widget.imageSize;
  }

  double getImageHeight(imageRatio) {
    if (imageRatio == ImageRatioRelativeTarget.height) {
      return widget.imageSize / imageRatio;
    }

    return widget.imageSize / imageRatio;
  }
}
