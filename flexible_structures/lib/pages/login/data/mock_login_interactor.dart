


import 'package:dio/dio.dart';
import 'package:request_states/requests/state_response.dart';

import 'login_interactor.dart';
import 'models/user_credentials.dart';


class MockLoginInteractor extends LoginFormInteractor {
  @override
  Future<StateResponse> loginUserCredentials(UserCredentials userCredentials) async {

    bool isSuccess = true;//userCredentials.username == 'aaa@gmail.com';

    return StateResponse.fromResponse(Response(
      data: {
        "message": isSuccess ? null : "Email ou Senha Errados"
      },
      requestOptions: RequestOptions(), 
      statusCode: isSuccess ? 200 : 400,
    ));

  }
}