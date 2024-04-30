
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NotificationFaculty extends StatefulWidget {
  const NotificationFaculty({super.key});

  @override
  State<NotificationFaculty> createState() => _NotificationFacultyState();
}

class _NotificationFacultyState extends State<NotificationFaculty> {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final currentUser = FirebaseAuth.instance.currentUser!;
    final usersCollection = FirebaseFirestore.instance.collection('Users');

    String? userEmail;
    String? userName;

    @override
    void initState() {
      super.initState();
      getUserData();
    }

    Future<void> getUserData() async {
      User? user = _auth.currentUser;
      if (user != null) {
        setState(() {
          userEmail = user.email;
        });

        // Retrieve user name from Cloud Firestore
        DocumentSnapshot<Map<String, dynamic>> snapshot =
            await _firestore.collection('Users').doc(currentUser.email).get();
        if (snapshot.exists) {
          setState(() {
            userName = snapshot.data()?['username'];
          });
        }
      }
    }
Future<void> popupNotification(Function(String) onSubmitted) async {
    String enteredText = await showDialog(
      context: context,
      builder: (BuildContext context) {
        String text = '';
        return AlertDialog(
          scrollable: true,
          title: const Text("Add Information"),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              child: TextFormField(
                onChanged: (value) {
                  text = value;
                },
                decoration: const InputDecoration(
                  labelText: "Information",
                  icon: Icon(Icons.info),
                ),
                maxLines: 5, // Set to null for multiline input
                keyboardType: TextInputType
                    .multiline, // Set the keyboard type for multiline input
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text("submit"),
              onPressed: () {
                
                Navigator.of(context).pop(text); // Pass text to the caller
              },
            ),
          ],
        );
      },
    );

    if (enteredText.isNotEmpty) {
      onSubmitted(enteredText);
    }
  }

 
  @override
  Widget build(BuildContext context) {
   void sendMessage(String message) {
    FirebaseFirestore.instance.collection('messages').add({
      'username': userName,
      'text': message,
      'timestamp': Timestamp.now(),
    });
  }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          popupNotification(sendMessage);
        },
        child: const Text(
          "+",
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.w400),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('messages').orderBy('timestamp', descending: true).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              return MyCard(cardTitle: data['username'], cardSubTitle: data['text']);
            }).toList(),
          );
        },
      ),
    );
  }
}

class MyCard extends StatelessWidget {
  final String cardTitle;
  final String cardSubTitle;
  const MyCard({
    super.key,
    required this.cardTitle,
    required this.cardSubTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: Container(
                width: 50, // Set width and height to make it a square container
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle, // Set the shape to circle
                ),
                child: const Icon(Icons.person,
                    size: 40,
                    color: Colors.white), // Centered icon with white color
              ),
              title: Text(
                cardTitle,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
              subtitle: Text(cardSubTitle),
            ),
          ],
        ),
      ),
    );
  }
}
