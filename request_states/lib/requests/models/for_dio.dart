
import 'package:dio/dio.dart';
import 'package:request_states/process/request_process.dart';
import 'package:request_states/requests/backend_request.dart';
import 'package:request_states/requests/state_response.dart';


extension DioExtension on Dio {
  callRequest({
    required String path,
    required HttpMethod method,
  }) {
    return fetch(RequestOptions(path: path, method: method.string()));
  }
}


extension FutureDioRequest on Future<StateResponse> {
  RequestProcess<StateResponse> andListenToRequest() {
    return RequestProcess(this, StatusResolver.requestStatusResolver);
  }
}

