

import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:request_states/process/request_process.dart';
import 'package:request_states/requests/state_response.dart';


import '../data/login_interactor.dart';
import '../data/models/user_credentials.dart';
import '../data/singletons/user_session.dart';

part './login_form_state.dart';
part 'login_form_event.dart';

abstract class FormController {
  Future<StateResponse> authenticate(UserCredentials userCredentials);
} 


// Bussness Logic Component
class LoginFormBloc extends Bloc<LoginFormEvent, LoginState> {


  LoginFormInteractor loginFormInteractor;

  // on<Event> -> handler
  LoginFormBloc({required this.loginFormInteractor,}) :
          super(LoginInitial()) {

    on<LoginButtonPressed>((event, emit) async => (
        await _authenticate(event.userCredentials, emit)));

    on<LoginFormInteracted>((event, emit) =>
    emit(state is LoginFailure ? LoginInitial() : state));

    on<EndLogin>((event, emit) => _loginEnd(emit, event));
  }

  void _loginEnd(Emitter<LoginState> emit, EndLogin event) async {

    await GetIt.I.get<UserSession>().saveLogin(event.confirmedUserCredentials);
    emit(LoginEnded());
  }


  Future<void> _authenticate(UserCredentials userCredentials, Emitter<LoginState> emit) async {

    // Muda o estado pra carregando
    emit(LoginLoading());

    await Future.delayed(Duration(seconds: 1));
    final backendResponse = await loginFormInteractor.loginUserCredentials(userCredentials);

    // backend success -> state login success
    // backend failure -> state login failure


    LoginState state = backendResponse.positiveStatus ?
    LoginSuccess(userData: backendResponse.data)
        : LoginFailure(error: backendResponse.message);

    emit(state);
  }




}