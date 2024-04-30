import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:skyscheduler/Components/otherbackground.dart';
// import '../../welcome_screen.dart';
import 'Components/my_drawer.dart';
import 'classroom_timetable.dart';
import 'faculty_timetable.dart';
import 'lab_timetable.dart';
import 'seminarhall_timetable.dart';

class StudentHomePage extends StatefulWidget {
  const StudentHomePage({super.key});

  @override
  State<StudentHomePage> createState() => _StudentHomePageState();
}

class _StudentHomePageState extends State<StudentHomePage> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      drawer:  StudentDrawer(),
      body: OtherBackground(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Time table, Class, Lab, Seminar buttons...
            //   ElevatedButton(
            //     onPressed:() async{
            //   await FirebaseAuth.instance.signOut().then((value) => Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen())));
            // },child: Text("logput")),
              Container(
                width: 220,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FacultyTimeTableScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "faculty timetable".toUpperCase(),
                  ),
                ),
              ),

              //class
              Container(
                width: 220,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClassroomTimetable(),
                      ),
                    );
                  },
                  child: Text(
                    "classroom timetable".toUpperCase(),
                  ),
                ),
              ),

              //lab
              Container(
                width: 220,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LabTimetable(),
                      ),
                    );
                  },
                  child: Text(
                    "lab timetable".toUpperCase(),
                  ),
                ),
              ),

              //seminar
              Container(
                width: 225,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SeminarhallTimeTableScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "seminarhall timetable".toUpperCase(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
