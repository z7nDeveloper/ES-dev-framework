
import 'package:flexible_structures/widgets/interactions/visiblity_on_hover/visibility_hover_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class VisibilityOnHoverElement extends StatefulWidget {
  final Widget child;
  final bool initialVisibility;
  final bool forceShowDisplay;
  const VisibilityOnHoverElement({super.key,
  required this.child,
  this.initialVisibility=false,
    this.forceShowDisplay=false,
  });

  @override
  State<VisibilityOnHoverElement> createState() => _VisibilityOnHoverElementState();
}

class _VisibilityOnHoverElementState extends State<VisibilityOnHoverElement> {


  VisibilityHoverCubit? visibilityHover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    visibilityHover =
    VisibilityHoverCubit(
      initialVisibility: widget.forceShowDisplay ? true :
      widget.initialVisibility,
    );

  }


  @override
  Widget build(BuildContext context) {

    return BlocProvider<VisibilityHoverCubit>(
      create: (context)=> visibilityHover!,
      child: widget.forceShowDisplay
        ? widget.child :
        MouseRegion(
          onEnter: (_) {
            setState(() {
              visibilityHover!.changeVisibility(true);
            });
          },
          onExit: (_) {
            setState(() {
              visibilityHover!.changeVisibility(false);
            });
          },
          child: widget.child),
    );
  }
}
