

part of 'login_form_bloc.dart';

// Events
abstract class LoginFormEvent {}

class LoginFormInteracted extends LoginFormEvent {}

class EndLogin extends LoginFormEvent {
  final Map<String, dynamic> confirmedUserCredentials;
  EndLogin({
    required this.confirmedUserCredentials,
  });
}

class LoginButtonPressed extends LoginFormEvent {
  final UserCredentials userCredentials;

  LoginButtonPressed({required this.userCredentials,});
}


