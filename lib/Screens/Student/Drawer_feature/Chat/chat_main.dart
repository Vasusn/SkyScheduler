import 'package:flutter/material.dart';
// import 'package:skyscheduler/Components/background.dart';
import 'package:provider/provider.dart';

import 'service/auth/auth_gate.dart';

import 'themes/theme_provider.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Chat'),
  //     ),
  //     body: Background(
  //       child: ListView(
  //           children: [
  //             ListTile(
  //               leading: CircleAvatar(
  //                 backgroundImage: NetworkImage('https://i.imgur.com/t3I82aD.jpg'),
  //               ),
  //               title: Text('Test User'),
  //               subtitle: Text('Hello, Stranger!'),
  //                onTap: () {
                  
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen()));
  //               },
  //             ),
  //             Divider(),
  //             ListTile(
  //               leading: CircleAvatar(
  //                 backgroundImage: NetworkImage('https://i.imgur.com/t3I82aD.jpg'),
  //               ),
  //               title: Text('Ishan'),
  //               subtitle: Text('This is a simple demonstration'),
  //               onTap: () {
                  
  //                 Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailsScreen()));
  //               },
  //             ),
              
  //           ],
  //         ),
  //     ),
      
  //   );
  // }
  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AuthGate(),
    );
    }}
