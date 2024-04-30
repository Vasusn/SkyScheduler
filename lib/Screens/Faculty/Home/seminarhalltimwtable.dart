import 'package:flutter/material.dart';
import 'package:skyscheduler/Components/background.dart';
import 'package:skyscheduler/constants.dart';

class SeminarhallTimeTableFacultySide extends StatefulWidget {
  const SeminarhallTimeTableFacultySide({Key? key}) : super(key: key);

  @override
  State<SeminarhallTimeTableFacultySide> createState() => _SeminarhallTimeTableFacultySideState();
}

class _SeminarhallTimeTableFacultySideState extends State<SeminarhallTimeTableFacultySide> {
  String dropdownValue = 'Select Seminarhall';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Seminarhall Timetable"),
        centerTitle: true,
      ),
      body: Background(child: SizedBox(
        width: MediaQuery.of(context).size.width,
        
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,  
          children: [
             const SizedBox(
              height: defaultPadding * 2,
            ),
            // Dropdown
            SizedBox(
              width: 200,
              
              child: DropdownButton<String>(
                value: dropdownValue,
                items: <String>[
                  'Select Seminarhall',
                  '229','339'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                      style: TextStyle(fontSize: 20),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: defaultPadding * 2,
            ),
            Text("Seminar No: $dropdownValue",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            // faculty name

            Text("Faculty name: Radhika patel",style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
            //faculty setting 
           const Text("Faculty Seating: 206",style:  TextStyle(fontSize: 20),),
            // faculty number
           const Text("Contact: +91 xxxxxxxxx",style:  TextStyle(fontSize: 20),),
            const SizedBox(
              height: defaultPadding * 2,
            ),
          
            //timetable
            SizedBox(
              child: InteractiveViewer(
                    panEnabled: false, // Set it to false
                    boundaryMargin: EdgeInsets.all(100),
                    minScale: 0.5,
                    maxScale: 3,
                    child: Image.asset(
                      'assets/images/demo.jpg',
                      width: defaultPadding * 25,
                      height: defaultPadding * 25,
                      fit: BoxFit.cover,
                    ),
                  ),
            ),
          ],
        ),
      ),)
    );
  }
}
