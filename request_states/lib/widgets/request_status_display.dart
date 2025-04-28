import 'package:flutter/material.dart';
import 'package:request_states/process/request_process.dart';
import 'package:request_states/widgets/request_view.dart';


class RequestStatusDisplay extends RequestView {
  final bool useDefaultOnNull;
  final dynamic forceSuccessWidget;
  final Map<RequestStatus, Map<String, dynamic>>? responseInfo;
  final Widget successWidget;

  //final RequestStatus? overridedRequestStatus;

  final EdgeInsets padding;
  final EdgeInsets? responsePadding;
  RequestStatusDisplay(
      {super.key,
      this.responseInfo,
      this.padding = const EdgeInsets.all(0),
      required RequestProcess? processRequest,
      required this.successWidget,
      //this.overridedRequestStatus,
      this.useDefaultOnNull = true,
      this.forceSuccessWidget = false,
      this.responsePadding})
      : super(processRequest: processRequest) {
    debugPrint(forceSuccessWidget.toString());
  }

  @override
  State<RequestStatusDisplay> createState() => _RequestStatusDisplayState();

  @override
  bool isCompatibleWithRequest(RequestProcess requestProcess) {
    return [
      RequestStatus.error,
      RequestStatus.empty,
      RequestStatus.loading,
    ].contains(requestProcess.requestStatus);
  }
}

class _RequestStatusDisplayState extends State<RequestStatusDisplay> {
  final Map<RequestStatus, Map<String, dynamic>> displayInfo = {};

  bool forceSuccess() {
    return (widget.forceSuccessWidget is Function
        ? widget.forceSuccessWidget()
        : widget.forceSuccessWidget);
  }

  RequestProcess? processRequest;

  @override
  void initState() {
    super.initState();
    if (widget.useDefaultOnNull) {
      Map<RequestStatus, Map<String, dynamic>> defaultInfo =
          getDefaultStatusInfo();
      displayInfo.addAll(defaultInfo);
    }

    debugPrint("init state");

    if (widget.responseInfo != null) {
      displayInfo.addAll(widget.responseInfo!);
    }

    if (widget.processRequest != null) {
      setRequest();
    }
  }

  void setRequest() {
    debugPrint("process request");

    if(widget.processRequest == processRequest) {
      return;
    }

    if(widget.processRequest == null) {
      return;
    }

    widget.processRequest!.onTryProcess(() {
      if (!mounted) return;

      if (forceSuccess()) {
        return;
      }
      setState(() {});
    });

    widget.processRequest!.listenForResponse(() {
      if (!mounted) return;
      debugPrint(widget.processRequest?.requestStatus.toString());
      /*if (forceSuccess()) {
        return;
      }*/
      setState(() {});
    });
  }

  Map<RequestStatus, Map<String, dynamic>> getDefaultStatusInfo() {
    Map<String, dynamic> badResponse = {
      "icon": Icons.error,
      "label": "Ocorreu um erro inesperado.",
    };
    return {
      RequestStatus.empty: {
        "icon": Icons.search,
        "label": "Não encontramos resultado para sua busca.",
      },
      RequestStatus.error: badResponse,
      RequestStatus.invalid: badResponse,
      RequestStatus.loading: {
        "icon": const CircularProgressIndicator(
            value: null, color: Color(0xff93467E)),
        "label": "Aguarde",
      },
      RequestStatus.timeout: {
        "icon": Icons.warning,
        "label": "Timeout!"
      }
    };
  }

  static const double labelPadding = 24;
  @override
  Widget build(BuildContext context) {

    if (widget.processRequest == null ||
        widget.processRequest?.requestStatus == RequestStatus.success ||
        forceSuccess()) {
      return widget.successWidget;
    }

    debugPrint("value for process : " +
        (widget.processRequest?.requestStatus.toString() ?? ""));
    Map<String, dynamic> statusDisplayInfo =
        displayInfo[widget.processRequest?.requestStatus]
            as Map<String, dynamic>;

    return StatusDisplay(
      icon: statusDisplayInfo['icon'],
      information: statusDisplayInfo["label"],
      padding: (widget.processRequest?.requestStatus == RequestStatus.success
          ? null
          : widget.responsePadding) ??
          widget.padding,
    );


  }


}




class StatusDisplay extends StatelessWidget {
  final dynamic icon;
  final String? information;
  final EdgeInsets? padding;
  const StatusDisplay({super.key, this.icon, this.information, this.padding});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
            getStatusDisplayIcon(),
          Padding(
            padding: EdgeInsets.only(top: _RequestStatusDisplayState.labelPadding),
            child: Text(
              information??'',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w700, fontSize: 20
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getStatusDisplayIcon() {
    late Widget displayIcon;
    if (icon is Widget) {
      displayIcon = icon;
    } else {
      displayIcon = Icon(
        icon as IconData,
        color: const Color(0xff93467E),
        size: 40,
      );
    }
    return displayIcon;
  }
}
