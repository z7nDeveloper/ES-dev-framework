



import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaddingBloc extends Cubit<EdgeInsets> {

  PaddingBloc(super.initialState);

}

class GlobalPadding extends StatelessWidget {

  static const EdgeInsets defaultPaddingMultiplier = EdgeInsets.all(1);

  final EdgeInsets paddingMultiplier;
  final Widget child;
  const GlobalPadding({
    this.paddingMultiplier=defaultPaddingMultiplier,
    required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaddingBloc, EdgeInsets>(
      bloc: PaddingBloc(EdgeInsets.zero),
      builder: (context, globalPadding) {
        return Padding(
            padding: EdgeInsets.only(
              left: globalPadding.left * paddingMultiplier.left,
              right: globalPadding.right * paddingMultiplier.right,
              top: globalPadding.top * paddingMultiplier.top,
              bottom: globalPadding.bottom * paddingMultiplier.bottom,
            ),
          child: child,


        );
      }
    );
  }
}
