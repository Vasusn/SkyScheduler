import 'package:flutter/material.dart';

import '../../../../../constants.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final String senderTime;
  final bool sender;

  ChatBubble({required this.message, required this.senderTime, required this.sender});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sender ? Alignment.topRight : Alignment.topLeft,
      child: Card(
        color: sender ? kPrimaryColor : kPrimaryLightColor,
        margin: EdgeInsets.all(5),
        shape: RoundedRectangleBorder(
          borderRadius: sender
              ? BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(16.0),
                )
              : BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                  bottomRight: Radius.circular(16.0),
                ),
        ),
        elevation: 5, // Adjust the elevation as needed
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: sender ? CrossAxisAlignment.end : CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: TextStyle(color: sender ? kPrimaryLightColor : kPrimaryColor, fontSize: 17),
              ),
              Text(
                senderTime,
                style: TextStyle(color: sender ? kPrimaryLightColor : kPrimaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

