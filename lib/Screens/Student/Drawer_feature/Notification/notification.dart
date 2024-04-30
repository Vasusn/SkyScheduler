import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
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
        margin: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
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
              title: Text(cardTitle,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w600),),
              subtitle: Text(cardSubTitle),
            ),
          ],
        ),
      ),
    );
  }
}
