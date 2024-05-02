import 'package:chat_app/helper/consts.dart';
import 'package:chat_app/widgets/message_box.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/scholar.png', width: 50, height: 50),
            const Text('Chat', style: TextStyle(color: Colors.white))
          ],
        ),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return MessageBox();
      })
    );
  }
}
