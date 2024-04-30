import 'package:flutter/material.dart';
import '../../../Components/background.dart';
import 'Components/login_form.dart';
import 'Components/login_screen_top_image.dart';

class StudentLoginScreen extends StatelessWidget {
  const StudentLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          LoginScreenTopImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: StudentLoginForm(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}