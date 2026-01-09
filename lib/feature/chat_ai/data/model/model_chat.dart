

class ChatMessage {
  final String text;
  final bool isUser; // لو true يبقى المستخدم اللي باعت، لو false يبقى الـ AI

  ChatMessage({required this.text, required this.isUser});
}