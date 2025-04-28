import 'package:flutter/cupertino.dart';
import 'package:request_states/process/request_process.dart';

// wrap in a screen and use it to define behaviour depending on state of request view
class RequestCenteredView extends StatefulWidget {
  final Map<RequestStatus, Function(BuildContext context)> builders;
  final RequestProcess? process;
  final Function(BuildContext context) emptyBuilder;
  final Function(BuildContext context)? defaultBuilder;

  RequestCenteredView(this.builders, this.process, this.emptyBuilder,
      {this.defaultBuilder, Key? key})
      : super(key: key);

  @override
  State<RequestCenteredView> createState() => _RequestCenteredViewState();
}

class _RequestCenteredViewState extends State<RequestCenteredView> {
  Function(BuildContext context)? currentBuilder;

  @override
  void initState() {
    super.initState();

    widget.process?.listenForResponse(() {
      setState(() {
        setBuilder();
      });
    });

    if (widget.process?.requestStatus != null) {
      setBuilder();
    }
  }

  setBuilder() {
    debugPrint("setting builder, status is: ${widget.process!.requestStatus}");
    currentBuilder = widget.builders[widget.process?.requestStatus];
    currentBuilder ??= widget.defaultBuilder;
  }

  @override
  Widget build(BuildContext context) {
    if (currentBuilder == null) {
      return widget.emptyBuilder(context);
    }

    return currentBuilder!(context);
  }
}
