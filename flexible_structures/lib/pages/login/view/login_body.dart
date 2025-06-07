

import 'package:flexible_structures/pages/login/bloc/login_form_bloc.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';
import '../data/models/user_credentials.dart';
import '../login_navigator.dart';
import 'layout/login_layout.dart';



class LoginBody extends StatefulWidget {

  LoginBody({Key? key,}) : super(key: key);

  @override
  State<LoginBody> createState() => _LoginPageBodyState();

  static String wrongUserTypeMessageLabel = 'Conta errada!';
}

class _LoginPageBodyState extends State<LoginBody> {
  late final FormGroup form;

  @override
  initState() {



    super.initState();
    form = FormGroup({
      'email': FormControl<String>(
        validators: [Validators.required, Validators.email],
      ),
      'password': FormControl<String>(
        validators: [Validators.required, Validators.minLength(3)],
      ),
    });

    final loginBloc = context.read<LoginFormBloc>();
    form.valueChanges.listen((_) {
      loginBloc.add(LoginFormInteracted());
    });
  }

  Future onLogin() async {
    if (form.valid) {
      final loginBloc = context.read<LoginFormBloc>();
      loginBloc.add(LoginButtonPressed(
        userCredentials: UserCredentials(
          username: form.control('email').value,
          password: form.control('password').value,
        )
      ));
    }
  }

  @override 
  Widget build(BuildContext context) {
    return ReactiveFormBuilder(
      form: () => form,
      builder: (context, form, child) {
        return BlocConsumer<LoginFormBloc, LoginState>(
          listener: (context, state) async {

            // #TODO consider a login consumer handler...
            // the current approach is not type-safe

            final formBloc = context.read<LoginFormBloc>();

            Map handlers = {
              LoginEnded: (state)=> handleLoginEnded(context),
              LoginSuccess: (state)=> handleLoginSuccess(formBloc, state),
              LoginFailure: (state)=> handleLoginFailure(state)
            };

            Function? stateHandler = handlers[state.runtimeType];

            if(stateHandler != null) {
              stateHandler(state);
            }


          },
          builder: (context, state) {
            if(state is LoginLoading)  {
              form.markAsDisabled();
            } else {
              form.markAsEnabled();
            } 
            return DefaultLoginLayout(
              construction: LoginLayoutConstruction(
                onLogin: onLogin,
                state: state,
              ),
            );
          }
        );
      }
    );
  }

  void handleLoginFailure(LoginFailure state) {
    final error = state.error;
    form.control('email').setErrors({'server': error});
  }
    void handleLoginEnded(BuildContext context) {
    context.read<LoginNavigator>().navigateAfterLogin(context);
  }

  void handleLoginSuccess(LoginFormBloc formBloc, LoginSuccess state)
  async {
    // Logic for successful login
    await Future.delayed(Duration(milliseconds: 200));
    formBloc.add(EndLogin(confirmedUserCredentials: state.userData));
  }

}
