import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/consts.dart';
import '../models/message_model.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: const BoxDecoration(
            color: primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            )),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}

class MessageBoxForFriend extends StatelessWidget {
  const MessageBoxForFriend({required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(top: 16, left: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
        decoration: const BoxDecoration(
            color: Color(0xff026C87),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            )),
        child: Text(message.message, style: TextStyle(color: Colors.white)),
      ),
    );
  }
}







