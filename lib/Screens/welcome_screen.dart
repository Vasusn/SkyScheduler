import 'package:flutter/material.dart';

import '../Components/background.dart';
import '../Components/student_faculty_btn.dart';
import '../Components/welcome_image.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Background(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          WelcomeImage(),
          Row(
            children: [
              Spacer(),
              Expanded(
                flex: 8,
                child: StudentAndFacultyBtn(),
              ),
              Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}