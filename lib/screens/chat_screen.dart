import 'package:chat_app/helper/consts.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:chat_app/widgets/message_box.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubits/chat_cubit/chat_cubit.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(),
      child: Scaffold(
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
          body: ChatScreenContent()),
    );
  }
}

class ChatScreenContent extends StatelessWidget {
  ChatScreenContent({super.key});

  final controller = TextEditingController();
  final scrollController = ScrollController();
  var message = '';

  @override
  Widget build(BuildContext context) {
    String email = FirebaseAuth.instance.currentUser!.email!;
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(children: [
          Expanded(
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ChatSuccess) {
                  final messageList = state.messageList;
                  return ListView.builder(
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
                      });
                } else {
                  return const Placeholder();
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextField(
              controller: controller,
              onChanged: (value) async {
                message = value;
              },
              decoration: InputDecoration(
                hintText: 'Enter a message',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () async {
                    if (message.isEmpty) {
                      return;
                    }

                    controller.clear();
                    await BlocProvider.of<ChatCubit>(context)
                        .addMessage(message: message, email: email);
                    scrollController.animateTo(0,
                        duration: Duration(seconds: 1), curve: Curves.easeIn);
                  },
                ),
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
              ),
            ),
          )
        ]));
  }
}
