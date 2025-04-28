import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
part "request_status.dart";
part 'status_resolver.dart';

class RequestProcess<T> {
  T? data;
  RequestStatus requestStatus;

  Future<T?>? process;

  bool finished = false;

  RequestStatus Function(RequestProcess<T> processRequest, Object? err)
      resolveStatus;

  final List<Function()> _onProcess = [];

  final List<Function()> _onTryProcess = [];

  final bool lockCall;

  RequestProcess(this.process, this.resolveStatus,
      {this.lockCall = false,
      this.requestStatus = RequestStatus.loading,
        Map<RequestStatus, Function(RequestProcess)>? map,
      callDirectly = true}) {
    if (callDirectly) {
      tryProcess();
    }
    if(map != null){
      Map<RequestStatus, Function()> callMap = {};
      for(RequestStatus status in map.keys) {
        callMap[status] = (){map[status]!(this);};
      }
      mapResponse(callMap);
    }
  }

  tryProcess({notify = true}) {
    requestStatus = RequestStatus.loading;
    data = null;
    if (notify) {
      _onTryProcess.forEach((element) {
        element();
      });
    }
    _doProcess();
  }

  bool doingProcess = false;

  _doProcess() async {
    if (doingProcess && lockCall) {
      return;
    }

    doingProcess = true;
    try {
      data = await process;
      requestStatus = getResolveStatus();
      finished = true;
    } catch (err) {
      debugPrint(err.toString());
      data = null;
      requestStatus = resolveStatus(this, err);
      finished = true;
    }
    receivedResponse();
    doingProcess = false;
  }

  getResolveStatus() {
    return resolveStatus(this, null);
  }

  void listenForResponse(Function() function) {
    if (finished) {
      function();
      return;
    }
    _onProcess.add(function);
  }

  void mapResponse(Map<RequestStatus, Function()> map) {
    _onProcess.add(() {
      if (!map.containsKey(requestStatus)) {
        return;
      }
      map[requestStatus]!();
    });
  }

  void receivedResponse() {
    for (var element in _onProcess) {
      element();
    }
  }

  void stopProcess() {
    process!.ignore();
  }

  void onTryProcess(Function() listener) {
    _onTryProcess.add(listener);
  }

  static from(Future call) {
    return RequestProcess(call, StatusResolver.trueResolver);
  }
}



