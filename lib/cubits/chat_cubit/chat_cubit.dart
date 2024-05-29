import 'package:bloc/bloc.dart';
import 'package:chat_app/models/message_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

import '../../helper/consts.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatLoading()){
    getAllMessages();
  }

  List<MessageModel> messageList=[];

  final messages = FirebaseFirestore.instance.collection('messages');

  Future<void> addMessage({required String message,required String email}) async {
    messages.add({
      kMessage: message,
      kDate: DateTime.now(),
      'id': email
    });
  }
  getAllMessages(){
    print('getAllMessages() started');
    List<MessageModel> newList=[];
    messages.orderBy(kDate,descending: true).snapshots().listen((event){
      for (final doc in event.docs) {
        newList.add(MessageModel.fromJson(doc));
      }
      messageList=newList;
      newList.clear();
      emit(ChatSuccess(messageList));
    });
  }
}
