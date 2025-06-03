


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text:  TextSpan(
        children: [
           TextSpan(
            text: 'Esqueceu sua senha?',
            style:  TextStyle(color: Colors.blue),
            recognizer:  TapGestureRecognizer()
              ..onTap = () {
              /*context.push(
                  ForgotPasswordRoute().routePath
              );*/
              },
          ),
        ],
      ),
    );
  }
}
