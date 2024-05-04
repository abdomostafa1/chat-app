import 'package:chat_app/helper/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel(this.message);

  final String message;

  factory MessageModel.fromJson(QueryDocumentSnapshot json){
    return MessageModel(json[kMessage]);
  }
}
