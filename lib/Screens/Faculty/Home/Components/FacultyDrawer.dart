import 'package:flutter/material.dart';
import 'package:skyscheduler/Screens/Faculty/Drawer_feature/addData/addFacultyDataPage.dart';
import 'package:skyscheduler/Screens/Faculty/Drawer_feature/addData/addSeminarDataPage.dart';
import 'package:skyscheduler/Screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../Drawer_feature/Notification/notification.dart';
import '../../Drawer_feature/Profile/faculty_profile.dart';
import '../../Drawer_feature/addData/addClassroomDataPage.dart';
import '../../Drawer_feature/addData/addLabDataPage.dart';
import '../../Drawer_feature/chat/chat_main.dart';

class FacultyDrawer extends StatelessWidget {
   FacultyDrawer({
    super.key,
  });
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: StreamBuilder<DocumentSnapshot>(
            stream: FirebaseFirestore.instance
                .collection("Users")
                .doc(currentUser.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!.data() as Map<String, dynamic>;
                String fullName = userData['fullName'];

                // Split the full name by space
                List<String> parts = fullName.split(' ');

                // Extract the first part as the first name
                String firstName = parts.isNotEmpty ? parts.first : '';
                String firstInitial = firstName.isNotEmpty ? firstName[0] : '';
                return ListView(
                  padding: const EdgeInsets.all(0.0),
                  children: <Widget>[
                    UserAccountsDrawerHeader(
                      accountName: Text(userData['fullName']),
                      accountEmail: Text(userData['email']),
                      currentAccountPicture: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(firstName),
                      ),
                      otherAccountsPictures: <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Text(firstInitial.toUpperCase()),
                        ),
                      ],
                    ),
                    ListTile(
                      onTap: () => {Navigator.pop(context)},
                      title: const Text("Home"),
                      leading: const Icon(Icons.home),
                    ),
                    ListTile(
                      title: const Text("Profile"),
                      leading: const Icon(Icons.person),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FacultyProfileScreen()))
                      },
                    ),
                    ListTile(
                      title: const Text("Notifications"),
                      leading: const Icon(Icons.notification_add),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationFaculty()))
                      },
                    ),
                    ListTile(
                      title: const Text("Chat"),
                      leading: const Icon(Icons.chat),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ChatScreenF()))
                      },
                    ),
                    ListTile(
                      title: const Text("Add Faculty Data"),
                      leading: const Icon(Icons.data_array),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddFacultyDataPage()))
                      },
                    ),
                    ListTile(
                      title: const Text("Add classroom Data"),
                      leading: const Icon(Icons.data_array),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddClassroomDataPage()))
                      },
                    ),
                    ListTile(
                      title: const Text("Add lab Data"),
                      leading: const Icon(Icons.data_array),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddLabDataPage()))
                      },
                    ),

                    ListTile(
                      title: const Text("Add Seminar Data"),
                      leading: const Icon(Icons.data_array),
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddSeminarDataPage()))
                      },
                    ),
                    ListTile(
                      title: const Text("Logout"),
                      leading: const Icon(Icons.logout),
                      onTap: () async {
                        await FirebaseAuth.instance.signOut().then((value) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WelcomeScreen())));
                      },
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text('Error : ${snapshot.error}'),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }));
  }
}
