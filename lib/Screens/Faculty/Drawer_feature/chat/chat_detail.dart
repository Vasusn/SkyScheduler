import 'package:flutter/material.dart';

import 'Components/chat_bubble.dart';

class ChatDetailsScreen extends StatelessWidget {
  const ChatDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Username"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: true,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: false,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: true,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: false,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: true,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: false,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: true,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: false,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: true,
            ),
            ChatBubble(
              message: 'This is a simple demonstration.',
              senderTime: '12:00 pm',
              sender: false,
            ),
            ],
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
          height: 60,
          width: MediaQuery.of(context).size.width,
          child: TextField(
            decoration: InputDecoration(
              hintText: "Write something....",
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                onPressed: () {},
              ),
            ),
          )),
    );
  }
}

