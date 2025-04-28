
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../process/request_process.dart';


/*
class StateResponse {
  late int statusCode;
  late dynamic message;
  late dynamic data;
  StateResponse(Response response) {
    debugPrint("backend response");
    debugPrint(response.data.toString());
    debugPrint(response.data.runtimeType.toString());

    response.data ??= {};

    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
      } catch (err) {
        statusCode = 404;
        message = response.data;
        data = {};
        return;
      }
    }

    Map<String, dynamic>? responseData =
    mapOf(response);

    int codeIfFailed = response.statusCode ?? 404;
    try {
      statusCode = int.tryParse(
              (responseData?["status"] ?? responseData?["statusCode"])
                  .toString()) ??
          codeIfFailed;
    } catch (err) {
      statusCode = codeIfFailed;
    }

    debugPrint("inicialized status as " + statusCode.toString());
    debugPrint(responseData.toString());

    if (responseData is Map) {
      message = responseData?["message"] ?? "";
    }

    debugPrint("inicialized message");


    data = mapOfData(responseData?["response"]) ?? responseData;


    debugPrint("inicialized data");

    debugPrint('finished backend response');
  }

  Map<String, dynamic>? mapOf(Response<dynamic> response) {

    return mapOfData(response.data);
  }

  mapOfData(data) {
    if (data == null) {
      return null;
    }
    try {
      return Map<String, dynamic>.from(data);
    } catch (err) {
      return {"data": data};
    }
  }

  bool get positiveStatus => statusCode <= 299 && statusCode >= 200;

  bool get isSystemFailure => statusCode <= 599 && statusCode >= 500;

  String getErrorReport(
      {required String ifNoneFound, required List<String> expectedEntries}) {
    if (data is! Map) {
      return ifNoneFound;
    }

    for (String entryKey in expectedEntries) {
      if ((data as Map).containsKey(entryKey)) {
        return data[entryKey];
      }
    }

    return ifNoneFound;
  }

  static StateResponse fromData(Map<String, dynamic> map) {
    return StateResponse(Response(
      requestOptions: RequestOptions(path: '',),
      data: map,
        statusCode: 200
    ));
  }

  static StateResponse error() {
    return StateResponse(Response(requestOptions: RequestOptions(),
        statusCode: 500));
  }

  static StateResponse success({Map<String,dynamic>? data}) {
    return StateResponse(Response(requestOptions: RequestOptions(),
        statusCode: 200,
      data: data ?? <String,dynamic>{}
    ));
  }
}*/


class StateResponse<T> {
  late RequestStatus statusCode;
  late dynamic message;
  late T data;

  StateResponse(RequestStatus statusCode, dynamic message, T data) {
    this.statusCode = statusCode;
    this.message =message;
    this.data = data;
  }

  static StateResponse<Map<String, dynamic>> fromResponse(Response response) {
    debugPrint("backend response");
    debugPrint(response.data.toString());
    debugPrint(response.data.runtimeType.toString());

    response.data ??= {};

    if (response.data is String) {
      try {
        response.data = jsonDecode(response.data);
      } catch (err) {

        return StateResponse(RequestStatus.error, response.data, {});
      }
    }

    Map<String, dynamic>? responseData =
    _mapOf(response);

    String message ="";
    int statusCode = response.statusCode ?? 404;

    try {
      statusCode = int.tryParse(
          (responseData?["status"] ?? responseData?["statusCode"])
              .toString()) ??
          statusCode;
    } catch (err) {
    }

    debugPrint("inicialized status as " + statusCode.toString());
    debugPrint(responseData.toString());

    if (responseData is Map) {
      message = responseData?["message"] ?? "";
    }

    debugPrint("inicialized message");


    responseData = _mapOfData(responseData?["response"]) ?? responseData ?? {};


    debugPrint("inicialized data");

    debugPrint('finished backend response');

    return StateResponse<Map<String, dynamic>>(
        RequestStatusExtension.fromInt(statusCode)
        , message,
        responseData as Map<String, dynamic>);
  }

  static Map<String, dynamic>? _mapOf(Response<dynamic> response) {

    return _mapOfData(response.data);
  }

  static _mapOfData(data) {
    if (data == null) {
      return null;
    }
    try {
      return Map<String, dynamic>.from(data);
    } catch (err) {
      return {"data": data};
    }
  }

  bool get positiveStatus => statusCode == RequestStatus.success;

  bool get isSystemFailure => statusCode == RequestStatus.error;



  static StateResponse fromData(Map<String, dynamic> map) {
    return StateResponse(RequestStatus.success, "", map);
  }

  static StateResponse error() {
    return StateResponse(RequestStatus.error, "", {});
  }

  static StateResponse success({Map<String,dynamic>? data}) {
    return StateResponse(RequestStatus.success, "", data ?? {});
  }
}

extension StateResponseMapExtension on StateResponse<Map<String, dynamic>> {

  String getErrorReport(
      {required String ifNoneFound, required List<String> expectedEntries}) {

    for (String entryKey in expectedEntries) {
      if ((data as Map).containsKey(entryKey)) {
        return data[entryKey];
      }
    }

    return ifNoneFound;
  }

}