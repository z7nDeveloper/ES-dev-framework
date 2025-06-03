


part of 'login_form_bloc.dart';

abstract class LoginState implements RequestStatusProvider {
  @override
  RequestStatus? getStatus() {
    return null;
  }
}


class LoginInitial extends LoginState {}
class LoginLoading extends LoginState {}
class LoginEnded extends LoginState {}

class LoginSuccess extends LoginState {
  final Map<String, dynamic> userData;
  LoginSuccess({ required this.userData});
  @override
  RequestStatus? getStatus() {
    return RequestStatus.success;
  }
}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure({required this.error});

  @override
  RequestStatus? getStatus() {
    return RequestStatus.invalid;
  }
}
