



import 'package:flutter/material.dart';
import 'package:request_states/process/request_process.dart';

class ActionStatusIcon extends StatelessWidget {

  final RequestStatus? state;
  const ActionStatusIcon({super.key,
  required this.state,});

  @override
  Widget build(BuildContext context) {

    return {
      RequestStatus.loading: CircularProgressIndicator(),
      RequestStatus.success:Icon(Icons.check),
      RequestStatus.error: Icon(Icons.error),
      RequestStatus.invalid: Icon(Icons.warning)
    }[state] ?? Container();
  }
}
