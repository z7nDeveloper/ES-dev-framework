import 'package:flutter/cupertino.dart';

import '../layout.dart';

class LayoutOptionsController extends StatelessWidget {
  final List<Layout> layoutOptions;
  final ValueNotifier<int> layoutOption;
  const LayoutOptionsController(
      {Key? key, required this.layoutOptions, required this.layoutOption})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (layoutOption.value >= layoutOptions.length) {
      layoutOption.value = 0;
    }

    return layoutOptions[layoutOption.value];
  }
}
