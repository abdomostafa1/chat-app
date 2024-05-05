import 'package:chat_app/helper/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  MessageModel(this.message,this.id);

  final String message;
  final String id;

  factory MessageModel.fromJson(QueryDocumentSnapshot json){
    return MessageModel(json[kMessage],json['id']);
  }
}
