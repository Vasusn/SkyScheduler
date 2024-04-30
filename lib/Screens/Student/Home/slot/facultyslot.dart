import 'package:flutter/material.dart';

import '../../Drawer_feature/Chat/chat_main.dart';

class FacultySlot extends StatefulWidget {
  const FacultySlot({Key? key}) : super(key: key);

  @override
  State<FacultySlot> createState() => _FacultySlotState();
}

class _FacultySlotState extends State<FacultySlot> {
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
        title: Text('Day Schedule'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: days.length,
              itemBuilder: (context, index) {
                String day = days.keys.elementAt(index);
                Map<String, bool> slots = days[day]!;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        day,
                        style: TextStyle(fontSize: 25.0),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: slots.keys.map((slot) {
                        return ListTile(
                          title: Text(
                            slot,
                            style: TextStyle(
                              color: slots[slot]! ? Colors.red : null,
                              decoration: slots[slot]! ? TextDecoration.lineThrough : null,
                            ),
                          ),
                          onTap: () {
                            setState(() {
                              slots[slot] = !slots[slot]!;
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              slots[slot] = false;
                            });
                          },
                        );
                      }).toList(),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
     bottomNavigationBar: BottomAppBar(
      height: 60,
        child:
         TextButton(
           onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
           },
           child: Text(
             "Chat and Book slot".toUpperCase(),
           ),
         ),
      ),
     );
  }
}
