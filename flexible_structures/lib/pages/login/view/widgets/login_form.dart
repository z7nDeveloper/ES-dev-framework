

import 'package:flexible_structures/widgets/interactions/input_spacer.dart';
import 'package:flexible_structures/widgets/theme_related/reactive_input_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:reactive_forms/reactive_forms.dart';



class LoginForm extends StatelessWidget {
  final Widget? appending;

  const LoginForm({
    Key? key,
    this.appending,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        InputSpacer(),
        EmailInput(),
        InputSpacer(),
        PasswordInput(),
        InputSpacer(),
        appending ?? Container()
      ],
    );
  }
}



class EmailInput extends StatelessWidget {
  const EmailInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: 'email',
      decoration: GetIt.I.get<ReactiveInputTheme>().decoration('Insira o Email'),
      validationMessages: {
        ValidationMessage.required: (_) => 'Campo obrigatório',
        ValidationMessage.email: (_) => 'Email invalido',
        'server': (error) => error.toString(),
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveTextField<String>(
      formControlName: 'password',
      obscureText: true,
      decoration: GetIt.I.get<ReactiveInputTheme>().decoration('Insira a Senha'),
      validationMessages: {
        ValidationMessage.required: (_) => 'Campo obrigatório',
        ValidationMessage.minLength: (_) => 'Mínimo de 3 caracteres',
      },
    );
  }
}
