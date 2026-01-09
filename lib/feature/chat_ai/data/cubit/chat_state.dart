part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}
class ChatSuccess extends ChatState {
  final List<ChatMessage> messages;
  ChatSuccess(this.messages);
}
class ChatError extends ChatState {
  final String error;
  ChatError(this.error);
}
