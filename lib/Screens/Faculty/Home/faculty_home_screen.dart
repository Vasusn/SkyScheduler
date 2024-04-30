import 'package:flutter/material.dart';
import 'package:skyscheduler/Screens/Faculty/Home/Components/FacultyDrawer.dart';
import '../../../Components/otherbackground.dart';
import '../teat.dart';
import 'classroomtimetable.dart';
import 'facultyTimetable.dart';
import 'labtimetable.dart';
import 'seminarhalltimwtable.dart';

class FacultyHomeScreen extends StatelessWidget {
  const FacultyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
       double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty"),
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      drawer:  FacultyDrawer(),
      body: OtherBackground(
        child: SizedBox(
          width: screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Time table, Class, Lab, Seminar buttons...

              Container(
                width: 220,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddAvailabilitySlotPage(),
                      ),
                    );
                  },
                  child: Text(
                    "add".toUpperCase(),
                  ),
                ),
              ),
              Container(
                width: 220,
                margin: EdgeInsets.only(top: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FacultyTimeTable(),
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
                        builder: (context) => const ClassroomTimetableFacultySide(),
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
                        builder: (context) => const LabTimetableFacultySide(),
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
                        builder: (context) => const SeminarhallTimeTableFacultySide(),
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