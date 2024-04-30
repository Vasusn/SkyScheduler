import 'package:flutter/material.dart';
import '../../../Components/signupbackground.dart';
import 'Components/sign_up_top_image.dart';
import 'Components/signup_form.dart';
import 'Components/socal_sign_up.dart';

class FacultySignupScreen extends StatelessWidget {
  const FacultySignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const SignupBackground(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SignUpScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: FacultySignUpForm(),
              ),
              Spacer(),
            ],
          ),
           SocalSignUp()
        ],
      ),
    );
  }
}