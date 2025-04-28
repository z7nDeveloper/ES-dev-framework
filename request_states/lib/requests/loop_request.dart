


import 'package:flutter/cupertino.dart';


abstract class LoopedProtocol {


  int duration;
  int? stopInXTimes; // for debugging purposes

  Function()? onProtocolDone;

  LoopedProtocol({required this.duration, this.stopInXTimes,});

  Future? protocolCall ;

  bool stopped = false;

  startIfNotAlready() {
    /*if(protocolCall != null && stopped == false) {
      return;
    }*/

    if(protocolCall != null) {
      return;
    }

    start();
  }
  start() {
    stopped = false;
    protocolCall = callProtocol();
  }

  stop() {
    stopped =true;
    protocolCall?.ignore();
  }

  Future callProtocol() async {

    if(stopInXTimes != null) {
      stopInXTimes = stopInXTimes! - 1;
      if(stopInXTimes == 0) {
        return;
      }
    }
    await Future.delayed(Duration(seconds:duration ));
    try {

      await protocol();
    } catch(err) {

      debugPrint(err.toString());
    }
    if(onProtocolDone != null) {
      onProtocolDone!();
    }

    if(!stopped) {

      start();
    }
  }


  Future protocol();
}