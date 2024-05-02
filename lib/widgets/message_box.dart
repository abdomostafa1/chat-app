import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../helper/consts.dart';

class MessageBox extends StatelessWidget {
  const MessageBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment:Alignment.centerLeft,
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
        child: const Text('i am abdo mostafa',
            style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
