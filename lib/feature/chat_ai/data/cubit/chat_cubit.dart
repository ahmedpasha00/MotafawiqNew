import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../model/model_chat.dart';
import '../repo/chat_repository.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  final Box chatBox = Hive.box('chatBox'); // فتح الصندوق
  List<ChatMessage> allMessages = [];

  ChatCubit(this.repository) : super(ChatInitial()) {
    // أول ما الـ Cubit يشتغل، حمل الرسايل من Hive
    loadMessages();
  }

  void loadMessages() {
    final saved = chatBox.get('messages', defaultValue: []);
    if (saved.isNotEmpty) {
      // تحويل البيانات من Hive لشكل ChatMessage
      allMessages = List<ChatMessage>.from(
          saved.map((e) => ChatMessage(text: e['content'], isUser: e['role'] == 'user'))
      );
      emit(ChatSuccess(List.from(allMessages)));
    }
  }
  void clearChat() async {
    await chatBox.delete('messages'); // حذف من الذاكرة
    allMessages.clear(); // مسح القائمة في الكيوبت
    emit(ChatSuccess([])); // تحديث الشاشة لتكون فاضية
  }
  void sendMessage(String userMsg) async {
    // 1. إضافة رسالة المستخدم للقائمة
    allMessages.add(ChatMessage(text: userMsg, isUser: true));
    emit(ChatSuccess(List.from(allMessages)));
    emit(ChatLoading());



    try {
      // 2. تجهيز الـ History بالشكل اللي الـ Repository عاوزه
      // بنحول قائمة الـ allMessages لشكل الخريطة (Map) المطلوبة لـ Groq
      List<Map<String, dynamic>> history = allMessages.map((msg) {
        return {
          "role": msg.isUser ? "user" : "assistant",
          "content": msg.text,
        };
      }).toList();

      // 3. نرسل التاريخ بالكامل للـ Repository
      final aiResponse = await repository.getChatResponse(history);

      // 4. إضافة رد الـ AI وحفظ الكل في Hive
      allMessages.add(ChatMessage(text: aiResponse, isUser: false));

      // حفظ في Hive (بنحولها لـ Map بسيطة عشان Hive بيفهمها)
      final dataToSave = allMessages.map((msg) => {
        "role": msg.isUser ? "user" : "assistant",
        "content": msg.text,
      }).toList();
      await chatBox.put('messages', dataToSave);

      emit(ChatSuccess(List.from(allMessages)));
    } catch (e) {
      print("Error caught: $e");
      emit(ChatError("فشل الاتصال: $e"));
    }
  }
}