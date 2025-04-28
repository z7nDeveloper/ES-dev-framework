


part of 'request_process.dart';

class StatusResolver {
  static RequestStatus simpleListResolver<T>(
      RequestProcess<T> processRequest, err) {
    if (err != null || processRequest.data == null) {
      return RequestStatus.error;
    }

    if ((processRequest.data as List).isEmpty) {
      return RequestStatus.empty;
    }

    return RequestStatus.success;
  }

  static RequestStatus trueResolver<T>(RequestProcess<T> processRequest, err) {
    return RequestStatus.success;
  }

  static RequestStatus boolResolver(RequestProcess processRequest, err) {
    if (err != null ||
        processRequest.data == null ||
        processRequest.data == false) {
      return RequestStatus.error;
    }

    return RequestStatus.success;
  }

  static RequestStatus requestStatusResolver(
      RequestProcess processRequest, err) {
    debugPrint("erro: " + err.toString());

    if (err == null) {
      int statusCode = processRequest.data?.statusCode ?? 500;
      debugPrint("status code: " + statusCode.toString());
      return mapResponseStatusCode(statusCode);
    }

    if (err is! DioError) {
      return RequestStatus.error;
    }

    if ([
      DioErrorType.connectionTimeout,
      DioErrorType.receiveTimeout,
      DioErrorType.sendTimeout
    ].contains(err.error)) {
      return RequestStatus.timeout;
    }

    processRequest.data.data = (jsonDecode(processRequest.data.data));

    return RequestStatus.invalid;
  }

  static RequestStatus requestListStatusResolver(
      RequestProcess processRequest, err) {
    RequestStatus requestStatus = requestStatusResolver(processRequest, err);

    if (requestStatus == RequestStatus.success) {
      dynamic data = processRequest.data.data;
      return (data is List ? data.isEmpty :  ((data["response"] ?? data["documents"]) as List).isEmpty)
          ? RequestStatus.empty
          : requestStatus;
    }

    return requestStatus;
  }

  static RequestStatus documentsRequestStatusResolver(
      RequestProcess processRequest, err) {
    RequestStatus baseStatus = requestStatusResolver(processRequest, err);

    if (baseStatus == RequestStatus.success) {
      debugPrint(processRequest.data.data.toString());
      if (!processRequest.data.data.containsKey("documents")) {
        return RequestStatus.error;
      }

      bool returnEmpty = processRequest.data.data['documents'] is! List ||
          processRequest.data.data['documents'].isEmpty;

      if (returnEmpty) {
        return RequestStatus.empty;
      }
    }

    return baseStatus;
  }

  static RequestStatus Function(RequestProcess processRequest, Object? err)
  anyResolver(RequestStatus success) {
    return (p, err) => success;
  }
}

mapResponseStatusCode(int statusCode) {
  if (statusCode >= 500) {
    return RequestStatus.error;
  }

  if (statusCode >= 400) {
    return RequestStatus.invalid;
  }

  if (statusCode >= 200) {
    return RequestStatus.success;
  }

  return RequestStatus.error;
}