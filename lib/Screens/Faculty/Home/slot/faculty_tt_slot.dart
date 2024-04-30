import 'package:flutter/material.dart';

class FacultyTimetableSlot extends StatefulWidget {
  final dynamic data;

  const FacultyTimetableSlot({Key? key, required this.data}) : super(key: key);

  @override
  State<FacultyTimetableSlot> createState() => _FacultyTimetableSlotState();
}

class _FacultyTimetableSlotState extends State<FacultyTimetableSlot> {
  Map<String, Map<String, bool>> days = {
    'Monday': {'10:10-11:10': false, '12:10-2:10': false,},
    'Tuesday': {'9:10-11:10': false, '2:20-3:20': false,'3:20-4:20': false},
    'Wednesday': {'10:10-11:10': false, '12:10-1:10': false},
    'Thursday': {'2:20-3:20': false, '3:20-4:20': false},
    'Friday': {'12:10-1:10': false, '1:10-2:10': false},
    'Saturday': {'10:10-11:10': false, '12:10-1:10': false, '1:10-2:10': false, '2:20-3:20': false, '3:20-4:20': false},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Faculty Timetable Slot'),
      ),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (BuildContext context, int index) {
          String day = days.keys.elementAt(index);
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    day,
                    style: TextStyle(fontSize: 25),
                  ),
                ),
              ),
              Column(
                children: days[day]!.keys.map((time) {
                  return CheckboxListTile(
                    title: Text(
                      time,
                      style: TextStyle(
                        decoration:
                            days[day]![time]! ? TextDecoration.lineThrough : null,
                        color: days[day]![time]! ? Colors.red : null,
                      ),
                    ),
                    value: days[day]![time],
                    onChanged: (bool? value) {
                      setState(() {
                        days[day]![time] = value!;
                      });
                    },
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}