


import 'package:flexible_structures/responsive/media_queries.dart';
import 'package:flexible_structures/widgets/interactions/input_spacer.dart';
import 'package:flexible_structures/widgets/listing/flexible_listing.dart';
import 'package:flutter/material.dart';
import 'package:sign_button/constants.dart';
import 'package:sign_button/create_button.dart';


class AuthButtons extends StatelessWidget {
  const AuthButtons({super.key});

  @override
  Widget build(BuildContext context) {


    MediaQuery.of(context);

     return Column(
       children: [

         InputSpacer(),

         Text('Ou acesse por:'),
         Padding(
           padding: const EdgeInsets.only(top: 12.0),
           child: Wrap(
             spacing: 24,
             runSpacing: 24,
             //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: [
               SignInButton(
                 buttonType: ButtonType.google,
                 onPressed: () {},
               ),
               SignInButton(
                 buttonType: ButtonType.apple, onPressed: () {  },
               ),
             ],
           ),
         ),
       ],
     );
    return Container(
       //height: 60,
      child: FlexibleListing(
        deviceAxis: DeviceOption(
          defaultResult: Axis.horizontal,
          mobile: Axis.vertical
        ),
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

        children: [

          for(SignInType button in [
            SignInType.googleDark,
            SignInType.apple,
            SignInType.facebookNew,
          ])
          SystemSignInButton(
            type: button,
            onPressed: () {},
          ),

        ],
      ),
    );
  }
}


enum SignInType {
  googleDark,
  facebookNew,
  apple,
}

class SystemSignInButton extends StatelessWidget {
  final SignInType type;
  final Function() onPressed;
  const SystemSignInButton({super.key, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {

    OutlinedBorder shapeBorder=
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    );
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shapeBorder,
        padding: EdgeInsets.symmetric(
          vertical: 8,
        ).copyWith(left: 0),
        backgroundColor: {
          SignInType.googleDark: Colors.red,
          SignInType.facebookNew: Colors.blue,
          SignInType.apple: Colors.black,
        }[type] ?? Colors.black
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon({
              SignInType.googleDark: Icons.add,
              SignInType.facebookNew: Icons.add,
              SignInType.apple: Icons.add,
            }[type] ?? Icons.add),

            Text({
              SignInType.googleDark: 'Google',
              SignInType.facebookNew: 'Facebook',
              SignInType.apple: 'Apple',
            }[type] ?? 'Unknown'),
          ],
        ),
      ),
    );
  }
}
