import 'package:flexible_structures/widgets/graphical_item/interactive_document/responsive_image.dart';
import 'package:flexible_structures/widgets/graphical_item/interactive_document/zoom_button.dart';
import 'package:flutter/cupertino.dart';


enum ImageRatioRelativeTarget { width, height }

class InteractiveDocument extends StatefulWidget {
  final String imageFileName;

  final double imageSize;

  final ImageRatioRelativeTarget imageRatioUse;

  const InteractiveDocument({
    super.key,
    required this.imageSize,
    required this.imageFileName,
    this.imageRatioUse = ImageRatioRelativeTarget.height,
  });

  @override
  State<InteractiveDocument> createState() => _InteractiveDocumentState();
}

class _InteractiveDocumentState extends State<InteractiveDocument> {
  TransformationController controller = TransformationController();
  ValueNotifier<bool> zoomPicture = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    zoomPicture.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQuery.of(context).size.width;
    return ResponsiveImage(
      imageRatioUse: widget.imageRatioUse,
      imageSize: widget.imageSize,
      imageFileName: widget.imageFileName,
      imageBuilder: (imageConfiguration) {
        Widget image = SizedBox(
          width: imageConfiguration.imageSizeWidth,
          height: imageConfiguration.imageSizeHeight,
          child: imageConfiguration.getImage(
            fit: BoxFit.fill,
          ),
        );

        if (zoomPicture.value) {
          image = Padding(
            padding: const EdgeInsets.only(top: 12.0),
            child: InteractiveViewer(
                boundaryMargin: const EdgeInsets.all(-12),
                maxScale: 3,
                transformationController: controller,
                minScale: 1,
                child: image),
          );
        }

        return Center(
          child: Container(
            width: imageConfiguration.imageSizeWidth,
            height: imageConfiguration.imageSizeHeight,
            child: Stack(
              children: [
                image,
                ZoomButton(
                    imageConfiguration: imageConfiguration,
                    zoomPicture: zoomPicture,
                    controller: controller)
              ],
            ),
          ),
        );
      },
    );
  }
}
