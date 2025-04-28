


part of 'request_process.dart';

enum RequestStatus {
  empty,
  error,
  invalid,
  success,
  loading,
  timeout,
  frontEndError
}


extension RequestStatusExtension on RequestStatus {

  static fromInt(int status) {

    if (status >= 500) {
      return RequestStatus.error;
    }

    if (status >= 400) {
      return RequestStatus.invalid;
    }

    return RequestStatus.success;
  }
}

abstract class RequestStatusProvider {
  RequestStatus? getStatus();
}


class RequestStatusActionMapper<T> {
  final Map<RequestStatus, Function(T)> mapper;
  final Function(T)? otherwiseDo;
  final Function(T)? andAlsoDo;

  RequestStatusActionMapper(
      {this.otherwiseDo, this.andAlsoDo, required this.mapper});

  hasActionOf({required RequestStatus status}) {
    return mapper.containsKey(status);
  }

  mapAction({required RequestStatus status, required T data}) {
    if (!mapper.containsKey(status)) {
      if (otherwiseDo != null) {
        otherwiseDo!(data);
      }
    } else {
      mapper[status]!(data);
    }

    if (andAlsoDo != null) {
      andAlsoDo!(data);
    }
  }
}
