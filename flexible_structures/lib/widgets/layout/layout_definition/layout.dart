import 'package:flutter/cupertino.dart';

abstract class LayoutConstruction {}

abstract class Layout<T extends LayoutConstruction> extends StatelessWidget {

  final T construction;

  const Layout({super.key, required this.construction});
}
