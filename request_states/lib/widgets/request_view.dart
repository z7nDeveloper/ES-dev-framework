import 'package:flutter/cupertino.dart';
import 'package:request_states/process/request_process.dart';


abstract class RequestView<T> extends StatefulWidget {
  final RequestProcess<T>? processRequest;

  RequestView({required this.processRequest, super.key});

  bool isCompatibleWithRequest(RequestProcess<T> requestProcess);
}
