import 'package:chat_app/helper/consts.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  final messages = FirebaseFirestore.instance.collection('messages');

  final controller = TextEditingController();
  final scrollController = ScrollController();
  var enterMessageTextFieldValue = '';

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: messages.orderBy(kDate,descending: true).snapshots(),
              builder: (context, snapshot) {
                List<MessageModel> messageList = [];
                if (snapshot.hasData) {
                  for (final doc in snapshot.data!.docs) {
                    messageList.add(MessageModel.fromJson(doc));
                  }
                }
                return Column(children: [
                  Expanded(
                    child: ListView.builder(
                        reverse: true,
                        controller: scrollController,
                        itemCount: messageList.length,
                        itemBuilder: (context, index) {
                          if (messageList[index].id == email) {
                            return MessageBox(message: messageList[index]);
                          } else {
                            return MessageBoxForFriend(
                                message: messageList[index]);
                          }
                        }),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextField(
                      controller: controller,
                      onChanged: (value) async {
                        enterMessageTextFieldValue = value;
                      },
                      decoration: InputDecoration(
                        hintText: 'Enter a message',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {
                            if (enterMessageTextFieldValue.isEmpty) {
                              return;
                            }

                            controller.clear();
                            messages.add({
                              kMessage: enterMessageTextFieldValue,
                              kDate: DateTime.now(),
                              'id': email
                            });
                            scrollController.animateTo(
                                0,
                                duration: Duration(seconds: 1),
                                curve: Curves.easeIn);
                          },
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16)),
                      ),
                    ),
                  )
                ]);
              }),
        ));
  }
}
