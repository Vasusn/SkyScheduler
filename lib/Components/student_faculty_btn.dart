import 'package:flutter/material.dart';
import '../Screens/Faculty/Login/faculty_login_screen.dart';
import '../Screens/Student/Login/student_login_screen.dart';
import '../constants.dart';
class StudentAndFacultyBtn extends StatelessWidget {
  const StudentAndFacultyBtn({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const StudentLoginScreen();
                },
              ),
            );
          },
          child: Text(
            "student".toUpperCase(),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const FacultyLoginScreen();
                },
              ),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: kPrimaryLightColor,
            elevation: 0,
          ),
          child: Text(
            "faculty".toUpperCase(),
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}
