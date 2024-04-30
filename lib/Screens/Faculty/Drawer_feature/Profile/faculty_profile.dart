import 'package:flutter/material.dart';
import 'package:skyscheduler/Components/background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../constants.dart';

class FacultyProfileScreen extends StatefulWidget {
  const FacultyProfileScreen({super.key});

  @override
  State<FacultyProfileScreen> createState() => _FacultyProfileScreenState();
}

class _FacultyProfileScreenState extends State<FacultyProfileScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection('Users');
  final usenameController = TextEditingController();
  final emailController = TextEditingController();
  //edit field
  @override
  void initState() {
    
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text("Profile Page"),
          centerTitle: true,
        ),
        body: Background(
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
            children: [
              const SizedBox(
                height: 50,
              ),
              //profile pic
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle, // Set the shape to circle
                ),
                child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Text(firstInitial.toUpperCase(),style: TextStyle(fontSize: 55),),
                      ), // Centered icon with white color
              ),

              const SizedBox(
                height: 10,
              ),
              //user email
              Text(
                "Email : ${userData['email']}",
                textAlign: TextAlign.center,
                
                style: TextStyle(fontSize: 20,color: Colors.grey[700]),
              ),
              Text(
                "Username : ${userData['username']}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20,color: Colors.grey[700]),
              ),

              const SizedBox(
                height: 50,
              ),

              //user details
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "My Details",
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Your username",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Your Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Save".toUpperCase(),
                ),
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
            }),
          
          ));
  }
}

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final VoidCallback onPressed;
  const MyTextBox(
      {super.key,
      required this.text,
      required this.sectionName,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.primary,
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                onPressed: onPressed,
              ),
            ],
          ),
          Text(text),
        ],
      ),
    );
  }
}

/*
ListView(
            children: [
              const SizedBox(
                height: 50,
              ),
              //profile pic
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  shape: BoxShape.circle, // Set the shape to circle
                ),
                child: const Icon(
                  Icons.person,
                  size: 72,
                ), // Centered icon with white color
              ),

              const SizedBox(
                height: 10,
              ),
              //user email
              Text(
                "currentUser.email!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),
              Text(
                "currentUsername!",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey[700]),
              ),

              const SizedBox(
                height: 50,
              ),

              //user details
              Padding(
                padding: const EdgeInsets.only(left: 25),
                child: Text(
                  "My Details",
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Your username",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.person),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: defaultPadding),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  obscureText: true,
                  cursorColor: kPrimaryColor,
                  decoration: const InputDecoration(
                    hintText: "Your Email",
                    prefixIcon: Padding(
                      padding: EdgeInsets.all(defaultPadding),
                      child: Icon(Icons.email),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: defaultPadding),
              ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Save".toUpperCase(),
                ),
              ),
            ],
          ),
        
 */