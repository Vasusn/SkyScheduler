import 'package:flutter/material.dart';
import 'package:skyscheduler/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../Components/background.dart';

class LabTimetable extends StatefulWidget {
  const LabTimetable({super.key});

  @override
  State<LabTimetable> createState() => _LabTimetableState();
}

class _LabTimetableState extends State<LabTimetable> {
 String dropdownValue = 'Select Lab';
  String labNo = '';
  String labTTLink = '';
  bool isLoading = false;

  // Function to retrieve data from Firestore
  Future<void> getLabData(String name) async {
    try {
      setState(() {
        isLoading = true;
      });
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lab')
          .doc(name)
          .get();
      if (snapshot.exists) {
        setState(() {
          labNo = snapshot['lab_no'];
          labTTLink = snapshot['timetable_url'];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error retrieving data from Firestore: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lab Timetable"),
        centerTitle: true,
      ),
      body: Background(
        child: SizedBox(
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
                    'Select Lab',
                    '204','205','206','207','208','209','210',
                    
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
                      getLabData(newValue);
                    }
                  },
                ),
              ),
              const SizedBox(
                height: defaultPadding * 2,
              ),
              // faculty name
              Text(
                "Lab no.: $dropdownValue",
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              //faculty setting
              // Text(
              //   "Faculty Seating: $facultySeating",
              //   style: TextStyle(fontSize: 20),
              // ),
              // faculty number
              //  const Text("Contact: +91 7016457404",style:  TextStyle(fontSize: 20),),
              //faculty chat option
              const SizedBox(
                height: defaultPadding * 2,
              ),

              //timetable
              isLoading
                  ? Container(
                              height: defaultPadding * 15,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            )
                  : SizedBox(
                      child: InteractiveViewer(
                        panEnabled: false, // Set it to false
                        boundaryMargin: EdgeInsets.all(100),
                        minScale: 0.5,
                        maxScale: 3,
                        child: Image.network(
                          "$labTTLink",
                          
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              height: defaultPadding * 15,
                              child: Center(
                                child: CircularProgressIndicator(),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Center(
                              child: Text(''),
                            );
                          },
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