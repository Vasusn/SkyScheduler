import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AvailabilitySlot {
  String startTime;
  String endTime;
  bool available;

  AvailabilitySlot({
    required this.startTime,
    required this.endTime,
    required this.available,
  });

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'available': available,
    };
  }
}

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addAvailabilitySlot(String facultyId, String day, AvailabilitySlot slot) async {
    try {
      await _firestore
          .collection('faculty')
          .doc(facultyId)
          .collection('availability')
          .doc(day)
          .collection('slots') // Sub-collection for slots within each day
          .add(slot.toMap());
    } catch (e) {
      print('Error adding availability slot: $e');
    }
  }
}

class AddAvailabilitySlotPage extends StatefulWidget {
  @override
  _AddAvailabilitySlotPageState createState() => _AddAvailabilitySlotPageState();
}

class _AddAvailabilitySlotPageState extends State<AddAvailabilitySlotPage> {
  final FirestoreService _firestoreService = FirestoreService();
  TextEditingController _startTimeController = TextEditingController();
  TextEditingController _endTimeController = TextEditingController();
  bool _available = false;
  String _selectedDay = 'Monday'; // Default day is Monday

  Future<void> _addSlot(String facultyId) async {
    String startTime = _startTimeController.text.trim();
    String endTime = _endTimeController.text.trim();
    
    if (startTime.isEmpty || endTime.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please enter valid time slots')));
      return;
    }

    AvailabilitySlot slot = AvailabilitySlot(startTime: startTime, endTime: endTime, available: _available);
    await _firestoreService.addAvailabilitySlot(facultyId, _selectedDay, slot);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Slot added successfully')));
    _startTimeController.clear();
    _endTimeController.clear();
    setState(() {
      _available = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Availability Slot'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: _startTimeController,
              decoration: InputDecoration(labelText: 'Start Time (e.g., 9:00 AM)'),
            ),
            SizedBox(height: 16.0),
            TextFormField(
              controller: _endTimeController,
              decoration: InputDecoration(labelText: 'End Time (e.g., 11:00 AM)'),
            ),
            SizedBox(height: 16.0),
            CheckboxListTile(
              title: Text('Available'),
              value: _available,
              onChanged: (newValue) {
                setState(() {
                  _available = newValue ?? false;
                });
              },
            ),
            SizedBox(height: 16.0),
            DropdownButton<String>(
              value: _selectedDay,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedDay = newValue!;
                });
              },
              items: <String>['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Replace 'facultyId1' with actual faculty ID
                _addSlot('facultyId1');
              },
              child: Text('Add Slot'),
            ),
          ],
        ),
      ),
    );
  }
}