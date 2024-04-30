import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:skyscheduler/Screens/Faculty/Home/faculty_home_screen.dart';
import 'package:skyscheduler/Screens/Student/Home/student_home.dart';
import 'package:skyscheduler/Screens/welcome_screen.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context , snapshot){
          if(snapshot.hasData){
            // return StudentHomePage();
            return FacultyHomeScreen();
          }
          else{
            return WelcomeScreen();
          }
        },
      ),
    );
  }
}