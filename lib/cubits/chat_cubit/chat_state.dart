part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatLoading extends ChatState {}
final class ChatSuccess extends ChatState {
  ChatSuccess(this.messageList);
  final List<MessageModel> messageList;
}
