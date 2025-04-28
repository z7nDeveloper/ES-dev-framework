import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:request_states/requests/state_response.dart';
import 'package:request_states/requests/caller/request_caller.dart';
import 'arguments/argument_caller.dart';

  class ResponseRequestCaller<G>
    extends RequestCaller<G, StateResponse<Map<String, dynamic>>> {
  ResponseRequestCaller(super.request, {super.defaultArgument});

  @override
  runRequest(argument) async {
    debugPrint('overriden run request');
    try {
      return await super.runRequest(argument);
    } on DioException catch (e) {
      debugPrint('received a dio error');
      if (e.response != null) {
        debugPrint('Error had a response object');
        return StateResponse.fromResponse(e.response!);
      }
      debugPrint(e.toString());
      return StateResponse.fromResponse(Response(
        requestOptions: RequestOptions(path: ""),
        statusCode: 500,
        data: {
          "message": e.toString()
        }
      ));
    } catch (err) {
      return StateResponse.fromResponse(Response
        (requestOptions: RequestOptions(path: ""), statusCode: 500));
    }
  }
}
