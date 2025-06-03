


import 'package:request_states/requests/state_response.dart';
import 'models/user_credentials.dart';

abstract class LoginFormInteractor {

  Future<StateResponse> loginUserCredentials(UserCredentials userCredentials);
}