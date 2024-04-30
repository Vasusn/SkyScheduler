import 'package:flutter/material.dart';
import 'package:skyscheduler/Screens/Faculty/Home/faculty_home_screen.dart';
import '../../../../components/already_have_an_account_acheck.dart';
import '../../../../constants.dart';
import '../../Signup/faculty_signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FacultyLoginForm extends StatefulWidget {
  const FacultyLoginForm({
    Key? key,
  }) : super(key: key);

  @override
  State<FacultyLoginForm> createState() => _FacultyLoginFormState();
}

class _FacultyLoginFormState extends State<FacultyLoginForm> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
      showDialog(context: context, builder: (context){
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(email: emailController.text, password: passwordController.text).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=> FacultyHomeScreen())));
      } on FirebaseAuthException catch (e) {
        
        if(e.code == 'user-not-found'){
          wrongEmailMessage();
        }
        else if(e.code == 'wrong-password'){
          wrongPasswordMessage();
        }
      }

      Navigator.pop(context);
    }
    void wrongEmailMessage() {
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: const Text('Wrong Email'),
            content: const Text('Please enter a valid email'),
          );
        });
    }
    void wrongPasswordMessage() {
      showDialog(
        context: context, 
        builder: (context){
          return AlertDialog(
            title: const Text('Wrong Password'),
            content: const Text('Please enter a valid password'),
          );
        });
    }
  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          TextFormField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            cursorColor: kPrimaryColor,
            onSaved: (email) {},
            decoration: const InputDecoration(
              hintText: "Your email",
              prefixIcon: Padding(
                padding: EdgeInsets.all(defaultPadding),
                child: Icon(Icons.person),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: TextFormField(
              controller: passwordController,
              textInputAction: TextInputAction.done,
              obscureText: true,
              cursorColor: kPrimaryColor,
              decoration: const InputDecoration(
                hintText: "Your password",
                prefixIcon: Padding(
                  padding: EdgeInsets.all(defaultPadding),
                  child: Icon(Icons.lock),
                ),
              ),
            ),
          ),
          const SizedBox(height: defaultPadding),
          ElevatedButton(
            onPressed: signUserIn,
            child: Text(
              "Login".toUpperCase(),
            ),
          ),
          const SizedBox(height: defaultPadding),
          AlreadyHaveAnAccountCheck(
            press: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const FacultySignupScreen();
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
